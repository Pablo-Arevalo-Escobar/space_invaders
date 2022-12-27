extends Area2D

var direction = Vector2(0.0,-1.0)
var speed = 150.0

func init(dir):
	direction = dir

func _process(delta):
  position = position + speed * direction * delta

func _on_Bullet_area_entered(area):
	area.queue_free()
	queue_free()
	
