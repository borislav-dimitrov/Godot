extends Node

var client: Client = preload("res://scripts/client/client.gd").new()
var card_selected: Card
var card_to_spawn: PackedScene
var mouse_on_placement: bool = false
var card_holder
var field_grid

func change_card_selected(card: Card):
	card_selected = card
	card_to_spawn = card.card_on_board

func clear_card_selected():
	card_selected = null
	card_to_spawn = null


enum CARD_PROPS {
	MOVE_SPEED,
}
