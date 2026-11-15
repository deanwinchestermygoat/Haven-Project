extends CharacterBody2D
#3
const SPEED = 300.0
const JUMP_VELOCITY = -700.0

var respawn_point: Vector2
func respawn():
	velocity = Vector2.ZERO  
	position = respawn_point
	


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y > 1500:
			velocity.y = 1500

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var direction2 := Input.get_axis("moveleft", "moveright")
	if direction2:
		velocity.x = direction2 * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_flour_body_entered(body: Node2D) -> void:
	print("newflour")


func _on_area_2d_body_entered(body: Node2D) -> void:
	respawn()
