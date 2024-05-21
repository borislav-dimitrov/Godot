class_name Actor

extends CharacterBody2D

@onready var movement: ActorMovement = preload('res://Scripts/Actors/actor_movement.gd').new()

var nav: NavigationAgent2D
var direction: Vector2
var a_speed: float = 300
var max_health: int = 100
var curr_health: int
var is_player: bool = false

func _start():
	pass

func _process(delta):
	pass

func set_move_to_target(target: Vector2):
	nav.target_position = target

