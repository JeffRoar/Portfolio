extends Node2D

signal  scored

const SPEED := 200.0 #match floor speed


func _ready() -> void:
	$ScoreZone.connect("body_entered", Callable(self, "_on_score_zone_entered"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#move whole pipe pair to the left
	position.x -= SPEED * delta
	
	#remove when offscreen
	if position.x < -300:
		queue_free()
func _on_score_zone_entered(body):
	if body.name =="Bird":
		emit_signal("scored")
