class_name BattleFieldCell
extends ColorRect

@onready var anim: AnimationPlayer = $Anim

var mouse_over: bool = false

func _handle_click_down():
	print(name)

func _on_mouse_entered():
	mouse_over = true
	anim.play('mouse_enter')

func _on_mouse_exited():
	mouse_over = false
	anim.play('mouse_exit')
	

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Grab/click
				_handle_click_down()

