class_name GameWorld
extends Node

var game_manager: GameManager
var scene_manager: SceneManager
var combat_manager: CombatManager

var player_scn: String = 'res://Scenes/Actors/Player/player.tscn'

var player: Player
var initialized := false


func init() -> void:
	# Init player
	player = load(player_scn).instantiate()
	game_manager.player = player
	add_child(player)
	
	initialized = true

func clean_up() -> void:
	# Clean player
	player.queue()
	remove_child(player)
	player = null
	game_manager.player = null
	
	initialized = false
