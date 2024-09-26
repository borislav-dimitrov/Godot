class_name ClientManager
extends Node



var _client = preload('res://scripts/client_handling/client.gd')
var _all_clients: Array[Client] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_client_ids() -> Array[int]:
	var ids: Array[int] = []
	
	for client: Client in _all_clients:
		ids.append(client.id)
	
	return ids


func get_all_clients() -> Array[Client]:
	return _all_clients


func create_new_client(id: int) -> Client:
	var new_client: Client = _client.new()
	new_client.id = id
	
	_all_clients.append(new_client)
	return new_client


func delete_client(id: int):
	for client in _all_clients:
		if client.id == id:
			_all_clients.erase(client)


func clear():
	_all_clients.clear()
