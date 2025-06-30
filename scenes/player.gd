extends CharacterBody2D

# Movement
const MOVE_SPEED = 75
const JUMP_FORCE = -250
const GRAVITY = 700
const MAX_FALL_SPEED = 700
const DASH_SPEED = 400
const COYOTE_TIME = 0.1
const JUMP_BUFFER_TIME = 0.1

# State tracking
var dash_direction = Vector2.ZERO
var can_dash = true
var is_dashing = false
var coyote_timer = 0.0
var jump_buffer_timer = 0.0

func _physics_process(delta):
	# Horizontal movement
	var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = direction * MOVE_SPEED

	# Gravity
	if not is_dashing:
		if not is_on_floor():
			velocity.y += GRAVITY * delta
			if velocity.y > MAX_FALL_SPEED:
				velocity.y = MAX_FALL_SPEED
		else:
			velocity.y = 0
			can_dash = true
			coyote_timer = COYOTE_TIME

	# Coyote time timer
	if not is_on_floor():
		coyote_timer -= delta

	# Jump buffer
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME

	jump_buffer_timer -= delta

	# Jump
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = JUMP_FORCE
		jump_buffer_timer = 0
		coyote_timer = 0

	# Dash
	if Input.is_action_just_pressed("dash") and can_dash:
		is_dashing = true
		can_dash = false
		dash_direction = Vector2(Input.get_action_strength("move_left") - Input.get_action_strength("move_left"),
								 Input.get_action_strength("move_down") - Input.get_action_strength("move_up")).normalized()
		if dash_direction == Vector2.ZERO:
			dash_direction = Vector2(1, 0)  # default dash direction
		velocity = dash_direction * DASH_SPEED

	if is_dashing:
		velocity = dash_direction * DASH_SPEED
		# Optional: Add a short dash duration timer here
		is_dashing = false

	move_and_slide()
