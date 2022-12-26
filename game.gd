extends Node2D

var screen_size
var level = []
const level_cap = 9
var difficulty = 1

func _ready():
	screen_size = get_viewport_rect().size
	randomize()
	prepareLevelVar()

func prepareLevelVar():
	level.resize(level_cap)
	for i in range(level_cap):
		var row = []
		row.resize(level_cap)
		for j in range(level_cap):
				row[j] = 0
		level[i] = row

func clearLevel():
	for i in range(level_cap):
		for j in range(level_cap):
			level[i][j] = 0

func getLevelAt(pos):
	return level[pos/level_cap][pos%level_cap]

func setLevelAt(pos):
	level[pos/level_cap][pos%level_cap] = 1

func createLevel(count):
	clearLevel()
	var ran = level_cap*level_cap
	
	for i in range(count):
		var number = randi() % ran
		var shift = 0
		
		while (shift < ran and getLevelAt((number + shift) % ran)):
			shift = shift + 1
		
		setLevelAt(number + shift)
		ran = ran - 1

func startLevel():
	for i in range(level_cap*level_cap):
		if (getLevelAt(i)):
			var mob = load("Mob.tscn").instance()
			
			var row = i / level_cap
			var col = i % level_cap
			
			var lowerX = screen_size.x/3
			var xSteps = lowerX/8
			var xPos = screen_size.x/3 + col*xSteps
			
			var upperY = screen_size.y/3
			var ySteps = (upperY-screen_size.y/20)/8
			var yPos = screen_size.y/20 + row*ySteps
			
			mob.position = Vector2(xPos, yPos)
			add_child(mob)	


func _on_Player_playerReady():
	createLevel(difficulty)
	startLevel()
	difficulty = difficulty + 1
