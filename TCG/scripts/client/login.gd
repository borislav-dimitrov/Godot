class_name Login
extends Control

@onready var client: StreamPeer = StreamPeerTCP.new()


func _ready():
	G.client.client = client
	
