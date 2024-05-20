extends Node

@onready var game_manager: GameManager = %GameManager
@onready var game_world: GameWorld = %GameWorld
@onready var scene_manager: SceneManager = %SceneManager

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.scene_manager = scene_manager
	game_manager.game_world = game_world
	
	scene_manager.game_world = game_world
	scene_manager.game_manager = game_manager
	
	game_world.scene_manager = scene_manager
	game_world.game_manager = game_manager
	
	scene_manager.start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
