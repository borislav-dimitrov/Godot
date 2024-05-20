class_name SceneManager
extends Node

@onready var screen_fader: ScreenFader = %ScreenFader
var game_manager: GameManager
var game_world: GameWorld

# Scenes files
var main_menu_scn: String = 'res://Scenes/Menus/main_menu.tscn'
var level_1: String = 'res://Scenes/Levels/level_1.tscn'
var level_2: String = 'res://Scenes/Levels/level_2.tscn'

# Variables
var current_scene: String
var active_scene: Node2D
var main_menu: MainMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start_game():
	screen_fader.fade_in()
	show_main_menu()

func show_main_menu():
	# Clean up
	if active_scene:
		clear_active_scene()
	if game_world.initialized:
		game_world.clean_up()
	
	current_scene = 'main_menu'
	screen_fader.fade_in()
	main_menu = load(main_menu_scn).instantiate()
	main_menu.scene_manager = self
	get_parent().add_child(main_menu)

func hide_main_menu():
	main_menu.queue_free()
	get_parent().remove_child(main_menu)
	main_menu = null

func load_scene(scene: String) -> void:
	# Do some pre-work
	if current_scene == 'main_menu':
		hide_main_menu()
	
	# Load the new scene
	if scene == 'level_1':
		current_scene = scene
		active_scene = load(level_1).instantiate()
	elif scene == 'level_2':
		current_scene = scene
		active_scene = load(level_2).instantiate()
	else:
		active_scene = null
	
	if active_scene:
		game_world.add_child(active_scene)
	
	if scene.contains('level'):
		if not game_world.initialized:
			game_world.init()
		game_manager.start_level()

func transition_to(scene: String, transition_time: float = .5) -> void:
	screen_fader.transition_to(
		Callable(load_scene).bind(scene),
		transition_time
		)

func change_scene(scene: String) -> void:
	clear_active_scene()
	load_scene(scene)

func clear_active_scene() -> void:
	active_scene.queue_free()
	game_world.remove_child(active_scene)
