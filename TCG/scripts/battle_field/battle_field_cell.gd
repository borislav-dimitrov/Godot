class_name BattleFieldCell
extends Container

@onready var anim: AnimationPlayer = $Anim
@onready var bg: Sprite2D = $Background
@onready var content: CardOnBoard

@export var can_spawn: bool = false

var mouse_over: bool = false
var is_empty: bool = true
var is_hidden: bool = true

func show_cell():
	is_hidden = false
	anim.play('show_cell')

func hide_cell():
	is_hidden = true
	anim.play('hide_cell')

func _handle_rclick():
	if content:
		content.move(self)

func _handle_click_down():
	if is_hidden:
		return
	
	if can_spawn:
		content = G.card_to_spawn.instantiate()
		content.props = G.card_selected.props
		
		add_child(content)
		content.modulate = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
		
		G.card_selected.queue_free()
		G.clear_card_selected()
		G.field_grid.hide_grid()

func _on_mouse_entered():
	if is_hidden:
		return
	
	mouse_over = true
	anim.play('mouse_in')

func _on_mouse_exited():
	if is_hidden:
		return
	
	mouse_over = false
	anim.play('mouse_out')

func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Grab/click
				_handle_click_down()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				_handle_rclick()
