class_name PlayerInteraction
extends Area2D

var in_range: Array = []

func _on_body_entered(body):
	var groups = body.get_groups()
	if 'Interactable' in groups:
		in_range.append(body)

func _on_body_exited(body):
	if body in in_range:
		var idx = in_range.find(body)
		in_range.pop_at(idx)
