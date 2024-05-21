class_name Player
extends Actor

@onready var camera_2d: Camera2D = $Camera2D
@onready var navigation: NavigationAgent2D = $Navigation

@export var move_speed: float
@export var hp: int

func _ready():
	# Values
	is_player = true
	a_speed = move_speed
	max_health = hp
	curr_health = hp
	
	# Nodes
	nav = navigation
	nav.path_desired_distance = 4
	nav.target_desired_distance = 4

func _process(delta):
	pass

func _physics_process(delta):
	move(delta)

func move(delta):
	if Input.is_action_just_pressed("left_click"):
		set_move_to_target(camera_2d.get_global_mouse_position())
	
	movement.move(self, delta)
