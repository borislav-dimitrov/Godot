class_name BattleFieldUI
extends CanvasLayer

@onready var card_holder = %CardHolder
@onready var field_grid = %FieldGrid

# Called when the node enters the scene tree for the first time.
func _ready():
	G.card_holder = card_holder
	G.field_grid = field_grid


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
