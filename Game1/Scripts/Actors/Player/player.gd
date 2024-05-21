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
	move(delta)
	movement.move(self, delta)

func move(delta):
	if Input.is_action_just_pressed("left_click"):
		movement.set_movement_target(camera_2d.get_global_mouse_position())

