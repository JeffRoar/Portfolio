extends Node2D

@export var PipeScene: PackedScene
@onready var pipe_timer: Timer = $PipeTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pipe_timer.timeout.connect(_on_PipeTimer_timeout)
	
func _on_PipeTimer_timeout() -> void:
	var pipe = PipeScene.instantiate()
	add_child(pipe)
	
	#position pipe at the right edge with random vertical offset
	var screen_width = get_viewport_rect().size.x
	var pipe_y = randf_range(-270,200) #adjust range for difficutly
	pipe.position = Vector2(screen_width + 50, pipe_y)
