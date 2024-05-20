class_name Player

extends CharacterBody2D

@onready var camera_2d = $Camera2D
@onready var movement: PlayerMovement = preload('res://Scripts/Player/player_movement.gd').new()
@onready var nav: NavigationAgent2D = $Navigation

var direction: Vector2

func _start():
	movement.nav = nav

func _process(delta):
	pass

func _physics_process(delta):
	movement.move(self, delta)
