class_name Player
extends CharacterBody2D

@onready var camera_2d: Camera2D = $Camera2D
@onready var navigation: NavigationAgent2D = $Navigation
@onready var movement: PlayerMovement = preload('res://Scripts/Actors/Player/player_movement.gd').new()
@onready var interaction = $Interaction

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
	var mouse_pos: Vector2 = camera_2d.get_global_mouse_position()
	var space_state = get_world_2d().direct_space_state
	var query: PhysicsPointQueryParameters2D = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	var results: Array[Dictionary] = space_state.intersect_point(query)
	
	var interactable: Node2D = null
	
	for obj in results:
		var object = obj.collider
		var groups = object.get_groups()
		if 'Interactable' in groups:
			interactable = object
			if interactable in interaction.in_range:
				print('Interacting with %s' % interactable.name)
			else:
				movement.navigation.path_desired_distance = 30
				movement.navigation.target_desired_distance = 30
				movement.set_movement_target(interactable.global_position)
				print('Moving towards interactable %s' % interactable.name)
			break
	
	if not interactable:
		movement.navigation.path_desired_distance = 16
		movement.navigation.target_desired_distance = 16
		movement.set_movement_target(mouse_pos)
