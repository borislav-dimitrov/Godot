extends Node

var SERVER_PORT = 4242
var SERVER_IP = '127.0.0.1'
var MAX_CLIENTS = -1 # TODO - implement in case of bottlenecks

# Widgets
@onready var log_widget: TextEdit = %LogsText
@onready var server_state_widget: Label = %ServerStatusLabel
@onready var active_clients_ct_widget: Label = %ConnectionsCt
@onready var active_clients_widget: ItemList = %ActiveConnections
@onready var command_widget: LineEdit = %CommandWidget

# Enums
enum ServerStates { STOP, RUN }

# Mappings
var commands_map: Dictionary = {
	'kick': Utilities.kick_client,
}

# Variables
var server_peer: ENetMultiplayerPeer = null
var _current_server_state: ServerStates = ServerStates.STOP
var client_mgr: ClientManager = preload("res://scripts/client_handling/client_mgr.gd").new()
var ServerCommandTypes: Array[String] = ['ECHO']


# Called when the node enters the scene tree for the first time.
func _ready():
	_change_server_state(ServerStates.STOP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _start_server():
	Utilities.write_log(log_widget, 'Starting server...')
	
	server_peer = ENetMultiplayerPeer.new()
	var server_status = server_peer.create_server(SERVER_PORT)
	
	if server_status == OK:
		multiplayer.multiplayer_peer = server_peer
		multiplayer.peer_connected.connect(_add_connection)
		multiplayer.peer_disconnected.connect(_del_connection)
		Utilities.write_log(log_widget, 'Server was started successfuly!')
		_change_server_state(ServerStates.RUN)
	else:
		var msg: String = 'Something wen\'t wrong! Err Code - %s' % server_status
		Utilities.write_log(log_widget, msg)
		_change_server_state(ServerStates.STOP)


func _stop_server():
	if server_peer:
		Utilities.write_log(log_widget, 'Stopping the server....')
		server_peer.close()
		_change_server_state(ServerStates.STOP)
		client_mgr.clear()
		active_clients_widget.clear()
		active_clients_ct_widget.text = str(len(client_mgr.get_all_clients()))
	else:
		Utilities.write_log(log_widget, 'Server is not running!')


func _on_close():
	Utilities.write_log(log_widget, 'Closing....')
	_stop_server()
	get_tree().quit()


func _add_connection(id: int):
	Utilities.write_log(log_widget, 'Client %s has connected!' % id)
	active_clients_widget.add_item(str(id))
	client_mgr.create_new_client(id)
	active_clients_ct_widget.text = str(len(client_mgr.get_all_clients()))


func _del_connection(id: int):
	Utilities.write_log(log_widget, 'Client %s has disconnected!' % id)
	client_mgr.delete_client(id)
	_remove_client_from_active_clients(id)


func _change_server_state(state: ServerStates):
	if state == ServerStates.STOP:
		server_state_widget.text = 'Stopped'
		server_state_widget.add_theme_color_override('font_color', Color(1, 0, 0))
	elif state == ServerStates.RUN:
		server_state_widget.text = 'Running'
		server_state_widget.add_theme_color_override('font_color', Color(0, 1, 0))


func _remove_client_from_active_clients(id: int):
	client_mgr.delete_client(id)
	
	for item_nr in range(active_clients_widget.item_count):
		if active_clients_widget.get_item_text(item_nr) == str(id):
			active_clients_widget.remove_item(item_nr)
	
	active_clients_ct_widget.text = str(len(client_mgr.get_all_clients()))


func _on_text_edit_text_submitted(new_text: String):
	# Handle commands input
	var command: String = 'null'
	
	if ' ' in new_text:
		command = new_text.split(' ')[0].to_lower()
	else:
		command = new_text.to_lower()
	
	if command == 'kick':
		var id: int = int(new_text.split(' ')[-1])
		Utilities.kick_client(
			id, client_mgr.get_client_ids(), log_widget, _remove_client_from_active_clients
		)
	else:
		Utilities.write_log(log_widget, 'Invalid command %s' % command)
	
	command_widget.clear()

@rpc('any_peer')
func message(payload: Dictionary):
	if 'id' not in payload:
		return
	
	var response: Dictionary = {
		'id': _local_id(),
		'cmd': 'ECHO',
		'msg': ''
	}
	
	if 'cmd' not in payload:
		response['msg'] = 'Missing command type!'
		rpc_id(payload['id'], 'message', response)
	elif payload['cmd'] not in ServerCommandTypes:
		response['msg'] = 'Invalid command type - %s!' % payload['cmd']
		rpc_id(payload['id'], 'message', response)
	elif payload['cmd'] == 'ECHO':
		Utilities.write_log(log_widget, 'Client %s says %s!' % [payload['id'], payload['msg']])



func _local_id():
	return multiplayer.get_unique_id()
