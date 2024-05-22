class_name GameManager
extends Node

var game_world: GameWorld
var scene_manager: SceneManager
var combat_manager: CombatManager

var player: Player
var player_spawn_positions: Dictionary = {
	'level_1': Vector2(105, -75),
}

func start_level():
	move_player_to_spawn()

func teleport_player(coordinates: Vector2) -> void:
	player.position = coordinates

func move_player_to_spawn() -> void:
	if scene_manager.current_scene in player_spawn_positions:
		teleport_player(player_spawn_positions[scene_manager.current_scene])
