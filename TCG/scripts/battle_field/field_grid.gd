class_name FieldGrid
extends Control

@onready var animation_player = $AnimationPlayer

var is_visible: bool = false

func show_grid():
	if is_visible:
		return
	
	is_visible = true
	show()
	animation_player.play('fade_in')
	
func hide_grid():
	is_visible = false
	animation_player.play('fade_out')


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'fade_out':
		hide()
