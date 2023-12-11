extends StaticBody2D

var ball_position : Vector2
var distance : int
var move_by : int
var win_height : int
var p_height : int


func _ready():
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y


func _process(delta):
#	move paddle towards the ball
	ball_position = $"../Ball".position
	distance = position.y - ball_position.y

#to stop vershooting
	if abs(distance) > get_parent().PADDLE_SPEED * delta: 
		move_by = get_parent().PADDLE_SPEED * delta * (distance / abs(distance))
	else:
		move_by = distance

	position.y -= move_by

	#limit paddle movement to the window
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)

