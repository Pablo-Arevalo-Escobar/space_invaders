extends Area2D

var direction = Vector2(0.133333,-1.0)
var speed = 150.0



func init(dir):
	direction = dir


func _process(delta):
	if($lifeTimeTimer.is_stopped()):
		queue_free()
	position = position + speed * direction * delta

	

func _on_Bullet_area_entered(area):
	area.queue_free()
	queue_free()
	
