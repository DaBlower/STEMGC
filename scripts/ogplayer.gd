extends CharacterBody2D


@export var SPEED = 85.0
@export var JUMP_VELOCITY = -300.0

@onready var animatedsprite = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer

func _physics_process(delta: float) -> void:
	var was_on_floor = is_on_floor()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor or coyote_timer.time_left > 0.0):
		velocity.y = JUMP_VELOCITY
		coyote_timer.stop()
	
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0: # going right because direction can be -1, 0 or 1
		animatedsprite.flip_h = false # face right
	elif direction < 0: # going left
		animatedsprite.flip_h = true # face left
	# this is an elif, because if no buttons are pressed, the character just stays facing in the current direction
	
	if is_on_floor():
		if direction == 0:
			animatedsprite.play("idle")
		else:
			animatedsprite.play("run")
	else:
		animatedsprite.play("jump")

	
	# Applies the movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	if was_on_floor and !is_on_floor():
		coyote_timer.start()
