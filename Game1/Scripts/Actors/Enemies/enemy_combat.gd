class_name EnemyCombat

func trigger_start_combat(player: CharacterBody2D, enemy: CharacterBody2D):
	G.main_node.combat_manager.start_combat(player, enemy)
	
