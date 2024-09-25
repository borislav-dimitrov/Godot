class_name Login
extends Control

@onready var client: StreamPeer = StreamPeerTCP.new()
@onready var output = $VBoxContainer/Output


func _ready():
	var tst = WebSocketMultiplayerPeer().new()
	update_output('Connecting...')
	var connection_result: String = G.client.connect_to_server(client)
	
	get_tree().create_timer(3).timeout.connect(
		Callable(initialize).bind(connection_result)
	)

func initialize(connection_result):
	
	update_output(connection_result, false)
	
	var payload: Dictionary = {
		'username': 'sky',
		'password': 'flying_Cat1'
	}
	
	var result: String = G.client.send_data(
		G.client.prepare_payload(payload, 'login')
	)
	update_output(result)
	
func update_output(message: String, append: bool = true) -> void:
	if append:
		output.text += message
	output.text = message
	


func _on_exit_pressed():
	get_tree().quit()


func _on_submit_pressed():
	update_output('Submit pressed!')
