extends Area2D

class_name KillZone
@onready var timer = $Timer
@export var world_kill := false

var player_body = null
var relocate_amt := 999999999

func _ready():
	position.x += relocate_amt
	get_tree().create_timer(.5).timeout.connect(relocate)

func _process(delta):
	if player_body:
		GLOBAL.game_manager.hit_player()

func _on_body_entered(body):
	if not body.is_player:
		return
	if not body.is_alive:
		return
	player_body = body
	
	if world_kill:
		GLOBAL.game_manager.kill_player()
	else:
		GLOBAL.game_manager.hit_player()
	
	if not body.is_alive:
		position.x += relocate_amt
		GLOBAL.screen_fader.transition_to()
		Engine.time_scale = 0.3
		body.get_node('CollisionShape2D').set_deferred('disabled', true)
		get_node('CollisionShape2D').set_deferred('disabled', true)
		body.velocity.y = 0
		body.velocity.y -= 200
		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1.0
	
func relocate():
	position.x -= relocate_amt


func _on_body_exited(body):
	if player_body != null and body == player_body:
		player_body = null
