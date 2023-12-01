extends Node2D

class_name TurnQueue

var active_char

func initialize():
	active_char = get_child(0)

func play_turn():
	await active_char.play_turn()
	var new_index: int = active_char.get_index() + 1 % get_child_count()
	active_char = get_child(new_index)
