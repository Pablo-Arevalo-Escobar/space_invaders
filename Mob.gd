extends Area2D

var direction = Vector2(-1.0,0.0)
var speed = 000.0
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
  position = position + speed * direction * delta
  

