class_name ActorMovement

func move(actor: Actor, delta: float):
	if actor.nav.is_navigation_finished():
		actor.velocity.x = 0
		actor.velocity.y = 0
		return
	
	var current_agent_pos: Vector2 = actor.global_position
	var next_path_pos: Vector2 = actor.nav.get_next_path_position()
	
	actor.velocity = current_agent_pos.direction_to(next_path_pos) * actor.a_speed
	actor.move_and_slide()
