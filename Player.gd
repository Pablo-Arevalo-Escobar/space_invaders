extends Area2D

export (PackedScene) var Bullet

var SPEED = 200
var screen_size
var upper_limit
var bullet_scene = preload("Bullet.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	screen_size = get_viewport_rect().size
	upper_limit = screen_size.y - screen_size.y/4

func _shoot():

	var b = bullet_scene.instance()
	b.position = position + Vector2(0,-10)
	get_parent().add_child(b);


func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("shoot"):
		_shoot()
	if Input.is_action_pressed("spawn"):
		var mob = load("Mob.tscn").instance()
		mob.position = position + Vector2(0,-250)
		get_parent().add_child(mob)
		
	
	position += velocity * SPEED *  delta;
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, upper_limit, screen_size.y)
