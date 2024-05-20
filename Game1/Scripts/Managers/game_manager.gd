class_name GameManager
extends Node

var game_world: GameWorld
var scene_manager: SceneManager

var player: Player
var player_spawn_positions: Dictionary = {
	'level_1': Vector2(60, -80),
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_level():
	move_player_to_spawn()

func teleport_player(coordinates: Vector2) -> void:
	player.position = coordinates

func move_player_to_spawn() -> void:
	if scene_manager.current_scene in player_spawn_positions:
		teleport_player(player_spawn_positions[scene_manager.current_scene])
