class_name PlayerMovement

var navigation: NavigationAgent2D
var move_speed: int
var anim_sprite: AnimatedSprite2D

func initialize(nav: NavigationAgent2D, ms: float, animated_sprite: AnimatedSprite2D):
	navigation = nav
	move_speed = ms
	anim_sprite = animated_sprite

func move(player: CharacterBody2D, delta: float):
	_handle_animations(player)
	
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

func _handle_animations(player: CharacterBody2D):
	if player.velocity.x < 0:
		anim_sprite.flip_h = true
		anim_sprite.play('Run')
	elif player.velocity.x > 0:
		anim_sprite.flip_h = false
		anim_sprite.play('Run')
	
	if player.velocity.x == 0:
		anim_sprite.play('Idle')
