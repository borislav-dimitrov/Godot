class_name CardOnBoard
extends Container

var props: Dictionary
var move_to: BattleFieldCell
var direction: int = 1
var run: bool = false

func _process(delta):
	if run:
		if move_to:
			if direction == 1 and global_position < move_to.global_position:
				global_position.x += direction * 150 * delta
				# play move animation
			elif direction == -1 and global_position > move_to.global_position:
				global_position.x += direction * 150 * delta
				# play move animation
		else:
			run = false
			move_to = null
			# play idle animation

func move(start_cell: BattleFieldCell):
	var cells: Array[BattleFieldCell] = G.field_grid.get_movement_cells(
		start_cell, props[G.CARD_PROPS.MOVE_SPEED]
		)
	
	if cells:
		run = true
		move_to = cells[-1]
		if global_position.x < move_to.global_position.x:
			direction = 1
		else:
			direction = -1
			
		cells[-1].content = self
		start_cell.content = null
