extends CharacterBody2D

@export var coyote_time = 0.1
@export var SPEED = 85.0
@export var JUMP_VELOCITY = -300.0


@onready var _animatedsprite = $AnimatedSprite2D
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func process(delta: float):
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = (JUMP_VELOCITY - get_gravity()) * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		_animatedsprite.play("running")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animatedsprite.play("idle")

	move_and_slide()
