extends Area2D

var direction = Vector2(0.0,-1.0)
var speed = 300.0

func _process(delta):
  position = position + speed * direction * delta

func _on_Bullet_area_entered(area):
	if area.is_in_group("mobs"):
		area.queue_free()
		queue_free()
	
