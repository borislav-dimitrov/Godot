class_name FieldGrid
extends Control

@onready var grid: GridContainer = $GridContainer

var is_visible: bool = false

func show_grid():
	if is_visible:
		return
	
	is_visible = true
	
	for row in grid.get_children():
		for cell in row.get_children():
			if cell is BattleFieldCell:
				cell.show_cell()
	
func hide_grid():
	is_visible = false
	
	for row in grid.get_children():
		for cell in row.get_children():
			if cell is BattleFieldCell:
				cell.hide_cell()

func _get_cell_info(cell: BattleFieldCell) -> Dictionary:
	var cell_name: String = cell.name
	var cell_nr: int = int(cell_name.substr(3, -1))
	var row: GridContainer = cell.get_parent()
	var row_nr: int = int(row.name.substr(2, -1))
	
	return {'cell_name': cell_name, 'cell_nr': cell_nr, 'row': row, 'row_nr': row_nr}

func get_movement_cells(start_cell: BattleFieldCell, move_speed: int):
	var counter: int = 0
	var cell_info: Dictionary = _get_cell_info(start_cell)
	var cells: Array[BattleFieldCell] = []
	
	for cell in cell_info['row'].get_children():
		var tmp_cell_info = _get_cell_info(cell)
		if tmp_cell_info['cell_nr'] <= cell_info['cell_nr']:
			continue
		
		cells.append(cell)
		counter += 1
		
		if counter >= move_speed:
			break
	
	return cells
