extends Node

func update_animation(animator: AnimationPlayer, velocity: Vector2):
	if velocity.length() == 0:
		animator.stop()
	else:
		var direction = "down"
		if velocity.x < 0: direction = "left"
		elif velocity.x > 0: direction ="right"
		
		animator.play("walk_%s" % direction)
