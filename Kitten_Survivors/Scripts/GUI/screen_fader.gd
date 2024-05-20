class_name ScreenFader

extends CanvasModulate

var _transitioning := false
var _transition_callback
var _transition_time: float
var start_level_after_transition := false

@onready var animation_player = $AnimationPlayer

func _start():
	pass

func fade_out():
	animation_player.play("fade_out")

func fade_in():
	animation_player.play("fade_in")

func transition_to(callback = null, transition_time: float = 0.0):
	_transition_callback = callback
	_transition_time = transition_time
	fade_out()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'fade_out':
		if _transition_callback != null:
			var temp = _transition_callback
			_transition_callback = null
			temp.call()
		
		if _transition_time:
			get_tree().create_timer(_transition_time).timeout.connect(fade_in)
		else:
			fade_in()

func _on_animation_player_animation_started(anim_name):
	if anim_name == 'fade_in':
		if start_level_after_transition:
			start_level_after_transition = false
			#GLOBAL.game_manager.start_level()
