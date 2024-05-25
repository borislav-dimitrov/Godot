extends Node2D

enum BUILDING_TYPE {
	TOWN_HALL,
	ARENA,
	TOWER
}
@export var building_type: BUILDING_TYPE = BUILDING_TYPE.TOWN_HALL

@onready var sprite_2d: Sprite2D = $Sprite2D

const INLINE = preload("res://materials/inline.tres")
const INLINE_OUTLINE = preload("res://materials/inline-outline.tres")


func _on_mouse_entered():
	sprite_2d.material = INLINE_OUTLINE


func _on_mouse_exited():
	sprite_2d.material = null

func _handle_click():
	if building_type == BUILDING_TYPE.TOWN_HALL:
		print("Going to the Town Hall menu...")
	elif building_type == BUILDING_TYPE.ARENA:
		print("Going to the Arena menu...")
	elif building_type == BUILDING_TYPE.TOWER:
		print("Going to the Tower menu...")

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# Grab/click
				_handle_click()
			else:
				# Release
				pass
