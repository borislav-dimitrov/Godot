class_name TreeEnemy
extends CharacterBody2D

@onready var movement: EnemyMovement = preload('res://Scripts/Actors/Enemies/enemy_movement.gd').new()

@export var navigation: NavigationAgent2D
@export var move_speed: float

func _ready():
	movement.initialize(navigation, global_position, move_speed)

func _physics_process(delta):
	movement.move(self)

func _on_recaltculate_timer_timeout():
	movement.recalc_path()

func _on_aggro_enter_body_entered(body):
	movement.set_target_node(body)

func _on_aggro_exit_body_exited(body):
	movement.clear_target_node(body)


func _on_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func _on_mouse_entered():
	pass # Replace with function body.
