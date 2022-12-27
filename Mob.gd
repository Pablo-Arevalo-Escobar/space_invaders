extends Area2D

var bullet_scene = preload("res://Bullet.tscn")
var direction = Vector2(-1.0,0.0)
var speed = 20.0
var screen_size
var ysteps
var xLimit
signal gameEnd

func _ready():
	screen_size = get_viewport_rect().size
	xLimit = screen_size.x/10
	ysteps = screen_size.y/15
	add_to_group("Enemies")
	
func _shoot():
	var b = bullet_scene.instance()
	b.init(Vector2(0,1.0))
	b.position = position + Vector2(0,20)
	get_parent().add_child(b)
	
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position,Vector2(position.x,screen_size.y),[self])
	if !result:
		if($ShotTimer.is_stopped()):
			var newWaitTime = randi()%10
			$ShotTimer.wait_time = newWaitTime
			$ShotTimer.start()
			_shoot()
	else:
		$ShotTimer.start()
	
func _process(delta):
	var temporaryPos
	temporaryPos = position + speed * direction * delta
	if (temporaryPos.x < xLimit or temporaryPos.x > screen_size.x - xLimit):
		var tree = get_tree()
		get_tree().call_group("Enemies", "turn_around")
		temporaryPos =  position
	position = temporaryPos + speed * direction * delta
  
func turn_around():
	if ($TurnLimit.is_stopped()):
		$TurnLimit.start()
		direction.x = direction.x * -1
		position.y = position.y + ysteps
		if(7*screen_size.y/8 < position.y):
			emit_signal("gameEnd")
		
  

