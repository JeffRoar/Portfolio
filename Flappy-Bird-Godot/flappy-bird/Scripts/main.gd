extends Node2D

@export var PipeScene: PackedScene
@onready var pipe_timer: Timer = $PipeTimer
@onready var bird = $Bird
@onready var game_over_image = $UI/GameOverImage 
@onready var start_game_image = $UI/StartGameImage 
@onready var digit1 = $ScoreDisplay/Digit1
@onready var digit2 = $ScoreDisplay/Digit2

var digit_textures = [
    preload("res://Assets/Sprites/0.png"),
    preload("res://Assets/Sprites/1.png"),
    preload("res://Assets/Sprites/2.png"),
    preload("res://Assets/Sprites/3.png"),
    preload("res://Assets/Sprites/4.png"),
    preload("res://Assets/Sprites/5.png"),
    preload("res://Assets/Sprites/6.png"),
    preload("res://Assets/Sprites/7.png"),
    preload("res://Assets/Sprites/8.png"),
    preload("res://Assets/Sprites/9.png")
]
var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pipe_timer.timeout.connect(_on_PipeTimer_timeout)
    bird.connect("died", Callable(self, "_on_bird_died"))
    game_over_image.visible = false
    start_game_image.visible = true
    get_tree().paused = true
    score = 0
    
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
            
    
func _on_pipe_scored():
    score += 1
    var tens = int(score/10)
    var ones = score % 10
    digit1.texture = digit_textures[ones]
    digit2.texture = digit_textures[tens]
