class_name PlayerMovement

extends CharacterBody2D

var speed: float = 300
var accel: float = 7

func move(player, delta: float):
	if Input.is_action_just_pressed("left_click"):
		player.nav.target_position = player.camera_2d.get_global_mouse_position()
	_move(player, delta)

func _move(player: Player, delta):
	if player.nav.is_navigation_finished():
		player.velocity.x = 0
		player.velocity.y = 0
		return
	
	var current_agent_pos: Vector2 = player.global_position
	var next_path_pos: Vector2 = player.nav.get_next_path_position()
	
	player.velocity = current_agent_pos.direction_to(next_path_pos) * speed
	player.move_and_slide()
