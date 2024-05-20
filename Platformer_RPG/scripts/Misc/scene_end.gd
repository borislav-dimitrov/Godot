extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	if body.is_alive:
		timer.start()
		GLOBAL.game_manager.win_level()

func _on_timer_timeout():
	GLOBAL.screen_fader.transition_to(GLOBAL.game_manager.win_level)
