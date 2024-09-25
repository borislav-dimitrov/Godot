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
	client_peer.create_client(server_ip, server_port)
	
	multiplayer.multiplayer_peer = client_peer
	
	print('Finished...')
	# TODO - do some status checks (success/failure/etc.)


func _disconnect_from_server():
	if not multiplayer.is_server():
		multiplayer.multiplayer_peer.disconnect_peer(1)

	
