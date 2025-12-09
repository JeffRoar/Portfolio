extends CharacterBody2D

#negative value = upwards force.
const flap_strength := -320.0 

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#Apply upward force
	if Input.is_action_just_pressed("Flap"):
		velocity.y = flap_strength 
	#move the bird
	move_and_slide() 
	#Rotate the bird based on vertical speed
	_update_rotation(delta) 
	
func _update_rotation(delta: float) -> void:
	#tilt up when flapping, and down when falling
	var target_rotation: float = clamp(velocity.y / 500.0, -0.5, 0.6) 
	rotation = lerp(rotation, target_rotation, 5.0 * delta)
