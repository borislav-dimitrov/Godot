class_name WizardSprite
extends CharacterBody2D

@onready var movement: EnemyMovement = preload('res://Scripts/Actors/Enemies/enemy_movement.gd').new()
@onready var combat: EnemyCombat = preload('res://Scripts/Actors/Enemies/enemy_combat.gd').new()
@onready var anim_sprite: AnimatedSprite2D = $SpriteHolder/AnimatedSprite2D

@export var navigation: NavigationAgent2D
@export var move_speed: float

func _ready():
	movement.initialize(navigation, global_position, move_speed, anim_sprite)

func _physics_process(_delta):
	movement.move(self)

func _on_recaltculate_timer_timeout():
	movement.recalc_path()

func _on_aggro_enter_body_entered(body):
	movement.set_target_node(body)

func _on_aggro_exit_body_exited(body):
	movement.clear_target_node(body)

func _on_combat_starter_body_entered(body):
	combat.trigger_start_combat(body, self)
