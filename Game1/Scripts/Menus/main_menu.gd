class_name MainMenu
extends Control

var scene_manager: SceneManager

func _on_new_game_pressed():
	scene_manager.transition_to('level_1')

func _on_exit_game_pressed():
	get_tree().quit()
