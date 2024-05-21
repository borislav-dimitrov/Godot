class_name Player
extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var navigation: NavigationAgent2D = $Navigation
@onready var movement: PlayerMovement = preload('res://Scripts/Actors/Player/player_movement.gd').new()

@export var move_speed: float
@export var hp: int

var max_health: int
var current_health: int

func _ready():
	movement.initialize(navigation, move_speed)
	
	# Values
	max_health = hp
	current_health = hp

func _process(delta):
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		mouse_click()
	movement.move(self, delta)

func move(delta):
	movement.set_movement_target(camera_2d.get_global_mouse_position())

func mouse_click():
	var mouse_pos = camera_2d.get_global_mouse_position()
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	var results = space_state.intersect_point(query)
	
	var clickable: Node2D = null
	
	for obj in results:
		var object = obj.collider
		var groups = object.get_groups()
		if 'Clickable' in groups:
			clickable = object
			print('Clicked %s' % object.name)
			break
	
	if not clickable:
		movement.set_movement_target(mouse_pos)
