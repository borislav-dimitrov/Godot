extends Node

@onready var screen_fader: ScreenFader = $ScreenFader
@onready var scene_manager: SceneManager = %SceneManager

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.scene_manager = scene_manager
	GLOBAL.screen_fader = screen_fader
	GLOBAL.scene_manager.show_main_menu()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

