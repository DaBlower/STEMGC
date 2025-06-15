extends CharacterBody2D

@export_group("Nodes")
@export var gravity: GravityC

func _physics_process(delta: float) -> void:
	gravity.handle_gravity(self, delta)
	
	move_and_slide()
