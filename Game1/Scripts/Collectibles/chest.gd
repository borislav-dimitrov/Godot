extends StaticBody2D

@onready var animation_player = $AnimationPlayer
var mouse_in: bool = false
@onready var border = $border

func _on_mouse_entered():
	mouse_in = true
	border.visible = true
	animation_player.play('hover')

func _on_mouse_exited():
	mouse_in = false
	border.visible = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'hover' and mouse_in:
		animation_player.play('hover')
	if anim_name == 'hover' and not mouse_in:
		animation_player.play('RESET')
