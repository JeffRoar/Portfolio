extends Node2D

const SPEED := 200.0 #match floor speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#move whole pipe pair to the left
	position.x -= SPEED * delta
	
	#remove when offscreen
	if position.x < -300:
		queue_free()
