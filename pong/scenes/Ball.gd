extends CharacterBody2D

var win_size : Vector2
var speed: int
var direction : Vector2

const START_SPEED : int = 500
const ACCELERATION : int = 50
const MAX_Y_VECTOR : float = 0.6


func _ready():
	win_size = get_viewport_rect().size


func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	var collider 
	if collision:
		collider = collision.get_collider()
		#if ball hits paddle
		if collider == $"../Player" or collider == $"../CPU":
			speed += ACCELERATION
			direction = new_direction(collider)
		#if ball hits wall
		else:
			direction = direction.bounce(collision.get_normal())



func new_ball():
#random start position and direction
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)
	speed = START_SPEED
	
	direction = random_direction()


func random_direction():
	var new_direction: Vector2
	new_direction.x = [-1, 1].pick_random()
	new_direction.y = randf_range(-1, 1)
	return new_direction.normalized()


#bounce direction dependent on hit location paddle
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y
	var distance = ball_y - pad_y
	var new_direction : Vector2
	
	if direction.x > 0:
		new_direction.x = -1
	else:
		new_direction.x = 1
	new_direction.y = (distance / (collider.p_height / 2)) * MAX_Y_VECTOR

	return new_direction.normalized()
