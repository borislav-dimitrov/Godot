class_name PlayerMovement

var navigation: NavigationAgent2D
var move_speed: int

func initialize(nav: NavigationAgent2D, ms: float):
	navigation = nav
	move_speed = ms

func move(player: CharacterBody2D, delta: float):
	if navigation.is_navigation_finished():
		player.velocity.x = 0
		player.velocity.y = 0
		return
	
	var current_agent_pos: Vector2 = player.global_position
	var next_path_pos: Vector2 = navigation.get_next_path_position()
	
	player.velocity = current_agent_pos.direction_to(next_path_pos) * move_speed
	player.move_and_slide()

func set_movement_target(target: Vector2):
	navigation.target_position = target
