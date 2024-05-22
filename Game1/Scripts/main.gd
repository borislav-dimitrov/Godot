class_name MainNode
extends Node

@onready var game_manager: GameManager = %GameManager
@onready var game_world: GameWorld = %GameWorld
@onready var scene_manager: SceneManager = %SceneManager
@onready var combat_manager: CombatManager = %CombatManager

# Called when the node enters the scene tree for the first time.
func _ready():
	G.main_node = self
	game_manager.scene_manager = scene_manager
	game_manager.game_world = game_world
	game_manager.combat_manager = combat_manager
	
	scene_manager.game_world = game_world
	scene_manager.game_manager = game_manager
	scene_manager.combat_manager = combat_manager
	
	game_world.scene_manager = scene_manager
	game_world.game_manager = game_manager
	game_world.combat_manager = combat_manager
	
	scene_manager.start_game()
