extends Node

@onready var client_peer: ENetMultiplayerPeer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _connect_to_server(server_ip='127.0.0.1', server_port=4242):
	print('Connecting to server...')
	client_peer = ENetMultiplayerPeer.new()
	var connection_status = client_peer.create_client(server_ip, server_port)
	
	# TODO - test these checks when connecting from different ip addr
	if connection_status == OK:
		multiplayer.multiplayer_peer = client_peer
		await get_tree().create_timer(1).timeout
		var payload: Dictionary = {
			'id': _local_id(),
			'msg': 'hello'
		}
		rpc_id(1, 'message', payload)
		print('Finished...')
	elif connection_status == ERR_ALREADY_IN_USE:
		print('Already connected!')
	elif  connection_status == ERR_CANT_CREATE:
		print('Couldn\'t connect!')
	else:
		print('Something wen\'t wrong! Err Code - %s' % connection_status)


func _disconnect_from_server():
	if not multiplayer.is_server():
		multiplayer.multiplayer_peer.disconnect_peer(1)


func _local_id():
	return multiplayer.get_unique_id()


@rpc('any_peer')
func message(payload: Dictionary):
	print('Client %s says %s!' % [payload['id'], payload['msg']])
