extends Area2D

var direction = Vector2(-1.0,0.0)
var speed = 020.0
var screen_size
var ysteps
var xLimit
signal gameEnd

func _ready():
	screen_size = get_viewport_rect().size
	xLimit = screen_size.x/10
	ysteps = screen_size.y/15
	add_to_group("Enemies")
	
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
		
  

