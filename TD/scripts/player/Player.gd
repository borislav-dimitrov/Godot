extends CharacterBody2D

var move_speed: float = 250.0

@onready var player_cam: Camera2D = $Camera2D
@onready var animations = load("res://scripts/animate.gd").new()
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var animator: AnimationPlayer = $AnimationPlayer

func _ready():
	# These values need to be adjusted for the actor's speed and the navigation layout.
	nav.path_desired_distance = 4.0
	nav.target_desired_distance = 4.0
	player_cam.position = position
	print_debug(player_cam.position, position)

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		set_movement_target(player_cam.get_global_mouse_position())
	move(delta)
	animations.update_animation(animator, velocity)

func move(delta):
	if nav.is_navigation_finished():
		velocity.x = 0
		velocity.y = 0
		return
	
	var current_agent_pos: Vector2 = global_position
	var next_path_pos: Vector2 = nav.get_next_path_position()
	
	velocity = current_agent_pos.direction_to(next_path_pos) * move_speed
	
	move_and_slide()

func set_movement_target(movement_target: Vector2):
	nav.target_position = movement_target
