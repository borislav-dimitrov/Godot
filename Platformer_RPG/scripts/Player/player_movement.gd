class_name Player
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var camera_2d = $Camera2D
@onready var player_info: PlayerInfo = preload("res://scripts/Player/player_info.gd").new()

var is_player: bool = true
var is_alive: bool = true
var pause_physics: bool = false

const SPEED = 100.0

const JUMP_VELOCITY = -250.0
var can_jump: bool = false
var jump_buffer: bool = false
@export var jump_buffer_time: float = .1
@export var coyote_time: float = .5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction := 1

func _physics_process(delta):
	#camera_2d.get_camera_position()
	if GLOBAL.game_manager.game_paused:
		return
		
	if pause_physics:
		velocity = Vector2(0, 0)
		return
	
	add_gravity(delta)
	if not is_alive:
		move_and_slide()
		return
	
	if Input.is_action_just_pressed("jump"):
		jump()

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	animations(direction)
	movement(direction)
	move_and_slide()

func add_gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		if can_jump:
			get_tree().create_timer(coyote_time).timeout.connect(coyote_timeout)
		
		velocity.y += gravity * delta
	else:
		can_jump = true
		if jump_buffer:
			jump()
			jump_buffer = false

func jump():
	# Handle jump.
	if can_jump:
		velocity.y = JUMP_VELOCITY
		can_jump = false
	else:
		jump_buffer = true
		get_tree().create_timer(jump_buffer_time).timeout.connect(on_jump_buffer_timeout)

func animations(direction: int):
	if direction > 0:
		last_direction = direction
		animated_sprite.flip_h = false
	elif direction < 0:
		last_direction = direction
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false if last_direction > 0 else true
	
	if is_on_floor():
		if direction == 0:
			animated_sprite.play('Idle')
		else:
			animated_sprite.play('Run')
	else:
		animated_sprite.play('Jump')

func movement(direction: int):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func on_jump_buffer_timeout() -> void:
	jump_buffer = false

func coyote_timeout():
	can_jump = false
