class_name Card
extends Container

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $Anim

@export var card_on_board: PackedScene

var start_pos
var card_highlighted: bool = false
var card_temp
var props: Dictionary = {
	G.CARD_PROPS.MOVE_SPEED : 2,
}

func _handle_click_down():
	if G.card_selected and G.card_selected == self:
		anim.play('deselect')
		G.clear_card_selected()
	elif card_highlighted and G.card_selected and G.card_selected != self:
		G.card_selected.anim.play('deselect')
		G.change_card_selected(self)
		anim.play('select')
	else:
		if card_highlighted:
			G.change_card_selected(self)
			anim.play('select')
	
	if G.card_selected and card_highlighted:
		# Show field grid
		G.field_grid.show_grid()
	else:
		G.field_grid.hide_grid()

func _handle_click_up():
	pass
	
func _on_mouse_entered():
	card_highlighted = true

func _on_mouse_exited():
	card_highlighted = false
	
func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Grab/click
				_handle_click_down()
			else:
				# Release
				_handle_click_up()
