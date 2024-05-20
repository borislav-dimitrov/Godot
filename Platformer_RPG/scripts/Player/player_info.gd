class_name PlayerInfo

extends Node

var max_health := 5
var max_lives := 3
var health: int = max_health:
	set(value):
		health = clamp(value, 0, max_health)
var lives: int = max_lives:
	set(value):
		lives = clamp(value, 0, max_lives)
var next_hit_delay: float = .5
var last_hit_time: float
var can_be_hit: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func take_hit():
	if not can_be_hit:
		return
	
	GLOBAL.game_manager.player.animation_player.play('take_hit')
	health -= 1
	can_be_hit = false
	GLOBAL.game_manager.player.get_tree().create_timer(next_hit_delay).timeout.connect(_enable_next_hit)
	if health <= 0:
		GLOBAL.game_manager.kill_player()

func lose_life():
	if health != 0:
		health = 0
	GLOBAL.game_manager.player.is_alive = false
	lives -= 1
	_check_game_over()

func _enable_next_hit():
	can_be_hit = true

func revive():
	health = 5
	
func _check_game_over():
	if lives <= 0:
		GLOBAL.game_manager.game_over()
