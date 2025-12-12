extends Node2D

@export var PipeScene: PackedScene
@onready var pipe_timer: Timer = $PipeTimer
@onready var bird = $Bird
@onready var game_over_image = $UI/GameOverImage 
@onready var start_game_image = $UI/StartGameImage 
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pipe_timer.timeout.connect(_on_PipeTimer_timeout)
    bird.connect("died", Callable(self, "_on_bird_died"))
    game_over_image.visible = false
    start_game_image.visible = true
    get_tree().paused = true
    
func _on_PipeTimer_timeout() -> void:
    var pipe = PipeScene.instantiate()
    add_child(pipe)
    pipe.connect("scored", Callable(self, "_on_pipe_scored"))
    
    #position pipe at the right edge with random vertical offset
    var screen_width = get_viewport_rect().size.x
    var pipe_y = randf_range(-270,200) #adjust range for difficutly
    pipe.position = Vector2(screen_width + 50, pipe_y)
    
func _on_bird_died():
    get_tree().paused = true
    game_over_image.visible = true
    
func _input(event: InputEvent) -> void:
    if get_tree().paused and start_game_image.visible:
        if event.is_action_pressed("Flap"):
            start_game_image.visible = false
            get_tree().paused = false
            
