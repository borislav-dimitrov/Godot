extends Node

class_name GameManager

var player: Player
var currency: int = 0

var spawn_positions: Dictionary = {
	'level_1': Vector2(100, -50),
	'level_2': Vector2(100, -390),
}

var level_started := false
var game_paused := false

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.game_manager = self

func _process(delta):
	if Input.is_action_just_pressed('pause_game'):
		if game_paused:
			unpause_game()
		else:
			pause_game()

func add_currency(amt: int = 1):
	currency += amt

func move_player_to_spawn() -> void:
	player.velocity = Vector2(0, 0)
	player.position = spawn_positions[GLOBAL.scene_manager.current_level]
	if not player.is_alive:
		respawn_player()
	
func spawn_player():
	player = load("res://scenes/player/Hero.tscn").instantiate()
	GLOBAL.game_world.add_child(player)
	GLOBAL.gui.update_gui_vitals()

func respawn_player():
	player.get_node('CollisionShape2D').set_deferred('disabled', false)
	player.velocity = Vector2(0, 0)
	player.is_alive = true
	player.pause_physics = false
	player.player_info.revive()
	GLOBAL.gui.update_gui_vitals()
	move_player_to_spawn()
	level_started = true

func hit_player():
	player.player_info.take_hit()
	GLOBAL.gui.update_health()

func kill_player():
	player.player_info.lose_life()
	GLOBAL.gui.update_gui_vitals()
	respawn_player()

func win_level():
	level_started = false
	GLOBAL.scene_manager.load_next_level()

func start_level():
	GLOBAL.gui.visible = true
	spawn_player()
	move_player_to_spawn()
	level_started = true

func game_over():
	level_started = false
	print("Game Over!")
	GLOBAL.scene_manager.show_main_menu()

func pause_game():
	Engine.time_scale = 0
	game_paused = true
	GLOBAL.scene_manager.show_pause_menu()
	
func unpause_game():
	Engine.time_scale = 1
	game_paused = false
	GLOBAL.scene_manager.hide_pause_menu()
