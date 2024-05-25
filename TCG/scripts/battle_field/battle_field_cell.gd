class_name BattleFieldCell
extends Container

@onready var anim: AnimationPlayer = $Anim
@onready var bg: Sprite2D = $Background
@onready var content: Sprite2D = $Sprite2D

@export var can_spawn: bool = false

var mouse_over: bool = false
var is_empty: bool = true

func _handle_click_down():
	if can_spawn:
		content.show()

func _on_mouse_entered():
	mouse_over = true
	anim.play('mouse_in')

func _on_mouse_exited():
	mouse_over = false
	anim.play('mouse_out')
	

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Grab/click
				_handle_click_down()
