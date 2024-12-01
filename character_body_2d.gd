extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if not is_on_floor() and velocity.y < 0:
		$AnimationPlayer.play("jump")
		
	if not is_on_floor() and velocity.y > 0:
		$AnimationPlayer.play("fall")
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("ui_left", "ui_right")
	if direction:
		if is_on_floor():
			if direction > 0:
				$Sprite2D.flip_h = false
			else:
				$Sprite2D.flip_h = true
				
			$AnimationPlayer.play("walk")
		velocity.x = direction * SPEED
	else:
		if is_on_floor():
			$AnimationPlayer.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
