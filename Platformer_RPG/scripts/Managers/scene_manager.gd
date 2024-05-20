extends Node

class_name SceneManager

var current_level: String = ''
var active_scene: Node2D = null
var main_menu_node: MainMenu = null
var pause_menu_node: PauseMenu = null
var load_game_menu_node: LoadGame = null

var main_menu: String = 'res://scenes/menus/main_menu.tscn'
var load_menu: String = 'res://scenes/menus/load_game_menu.tscn'
var pause_menu: String = 'res://scenes/menus/pause_menu.tscn'
var game_world: String = 'res://scenes/game_world.tscn'
var level_1: String = 'res://scenes/levels/level_1.tscn'
var level_2: String = 'res://scenes/levels/level_2.tscn'

func _ready():
	pass

func show_main_menu():
	if GLOBAL.game_world != null:
		GLOBAL.game_world.dispose()
	
	GLOBAL.screen_fader.fade_in()
	main_menu_node = load(main_menu).instantiate()
	get_parent().add_child(main_menu_node)

func hide_main_menu():
	main_menu_node.queue_free()
	get_parent().remove_child(main_menu_node)
	main_menu_node = null

func show_pause_menu():
	pause_menu_node = load(pause_menu).instantiate()
	active_scene.add_child(pause_menu_node)

func hide_pause_menu():
	pause_menu_node.queue_free()
	active_scene.remove_child(pause_menu_node)
	pause_menu_node = null

func show_load_game_menu():
	if main_menu_node == null:
		return
	
	load_game_menu_node = load(load_menu).instantiate()
	get_parent().add_child(load_game_menu_node)

func hide_load_game_menu():
	load_game_menu_node.queue_free()
	get_parent().remove_child(load_game_menu_node)
	load_game_menu_node = null

func spawn_game_world():
	var game_world = load(game_world).instantiate()
	get_parent().add_child(game_world)

func load_level(level: String = 'level_1'):
	if not GLOBAL.game_world:
		spawn_game_world()
	
	if main_menu_node:
		hide_main_menu()
	
	if level == 'level_1':
		current_level = level
		active_scene = load(level_1).instantiate()
	if level == 'level_2':
		current_level = level
		active_scene = load(level_2).instantiate()
	
	GLOBAL.game_world.add_child(active_scene)

func clear_scene():
	active_scene.queue_free()
	GLOBAL.game_world.remove_child(active_scene)

func restart_current_level():
	clear_scene()
	load_level(current_level)
	GLOBAL.game_manager.move_player_to_spawn()
	GLOBAL.game_manager.start_level()

func load_next_level():
	clear_scene()
	load_level(get_next_level())

func get_next_level() -> String:
	var current_level_nr: int = int(current_level.split('_')[-1])
	current_level_nr += 1
	return 'level_%s' % current_level_nr
