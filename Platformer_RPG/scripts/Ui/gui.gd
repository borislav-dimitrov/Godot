class_name GUI

extends CanvasLayer

@onready var health_1: TextureRect = $Health/Health1
@onready var health_2: TextureRect = $Health/Health2
@onready var health_3: TextureRect = $Health/Health3
@onready var health_4: TextureRect = $Health/Health4
@onready var health_5: TextureRect = $Health/Health5
@onready var life_1: TextureRect = $Life/Life1
@onready var life_2: TextureRect = $Life/Life2
@onready var life_3: TextureRect = $Life/Life3

var hp_textures: Array[TextureRect] = [health_1, health_2, health_3, health_4, health_5]
var lives_textures: Array[TextureRect] = [life_1, life_2, life_3]
var player_health: int
var player_lives: int

# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.gui = self
	hp_textures = [health_1, health_2, health_3, health_4, health_5]
	lives_textures = [life_1, life_2, life_3]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_health or player_lives:
		return
		
	update_player_vitals()

func update_player_vitals():
	if GLOBAL.game_manager:
		if GLOBAL.game_manager.player:
			player_health = GLOBAL.game_manager.player.player_info.health
			player_lives = GLOBAL.game_manager.player.player_info.lives
	
func update_gui_vitals():
	update_player_vitals()
	update_health()
	update_lives()
	
func update_health():
	update_player_vitals()
	if player_health == null:
		return
	
	for frame_idx in hp_textures.size():
		if frame_idx < player_health:
			hp_textures[frame_idx].visible = true
		else:
			hp_textures[frame_idx].visible = false
	
func update_lives():
	update_player_vitals()
	if player_lives == null:
		return
	
	for frame_idx in lives_textures.size():
		if frame_idx < player_lives:
			lives_textures[frame_idx].visible = true
		else:
			lives_textures[frame_idx].visible = false

