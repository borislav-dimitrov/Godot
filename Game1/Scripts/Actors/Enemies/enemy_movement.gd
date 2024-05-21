class_name EnemyMovement

var navigation: NavigationAgent2D
var move_speed: float
var target_node: Node2D = null
var home_pos: Vector2 = Vector2.ZERO
var is_player: bool = false

func initialize(nav: NavigationAgent2D, pos: Vector2, ms: float):
	navigation = nav
	home_pos = pos
	move_speed = ms
	
	# How far to stop before the target was reached
	navigation.path_desired_distance = 4
	navigation.target_desired_distance = 4

func move(enemy: CharacterBody2D):
	if navigation.is_navigation_finished():
		enemy.velocity.x = 0
		enemy.velocity.y = 0
		return
	
	#var axis = to_local(navigation.get_next_path_position()).normalized()
	var next_path_pos: Vector2 = navigation.get_next_path_position()
	enemy.velocity = enemy.global_position.direction_to(next_path_pos) * move_speed
	
	enemy.move_and_slide()

func recalc_path():
	if target_node:
		navigation.target_position = target_node.global_position
	else:
		navigation.target_position = home_pos

func set_target_node(body: CharacterBody2D):
	if body.get_class() == 'CharacterBody2D':
		target_node = body

func clear_target_node(body: CharacterBody2D):
	if body == target_node:
		target_node = null
