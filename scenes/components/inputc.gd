class_name InputC
extends Node

var input_horizontal: float = 0.0

func _process(_delta: float) -> void:
	input_horizontal = Input.get_axis("move_left", "move_right")
	
func get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")
