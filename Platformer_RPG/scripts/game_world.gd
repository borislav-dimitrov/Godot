extends Node

class_name GameWorld

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.game_world = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func dispose():
	queue_free()
	get_parent().remove_child(self)
