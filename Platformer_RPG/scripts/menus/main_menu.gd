class_name MainMenu
extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_exit_game_pressed():
	get_tree().quit()

func _on_new_game_pressed():
	GLOBAL.screen_fader.start_level_after_transition = true
	GLOBAL.screen_fader.transition_to(GLOBAL.scene_manager.load_level, 1)

func _on_options_pressed():
	pass # Replace with function body.

func _on_load_game_pressed():
	GLOBAL.scene_manager.show_load_game_menu()
