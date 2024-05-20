class_name GameWorld
extends Node

var game_manager: GameManager
var scene_manager: SceneManager

var player_scn: String = 'res://Scenes/Player/player.tscn'

var player: Player
var initialized := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
