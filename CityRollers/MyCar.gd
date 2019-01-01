extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (float) var max_speed = 100.0
export (float) var acceleration = 1.0


var direction = Vector2()
var target_pos = Vector2()
var target_direction = Vector2()
var is_moving = false

var speed = 0
var motion = Vector2()
var path

onready var grid = get_parent().get_node("Base")

func cartesian_to_isometric(vector):
	return Vector2(vector.x - vector.y, (vector.x + vector.y) / 2)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Vector2()
	speed = max_speed
	
	if Input.is_action_just_pressed("click"):
		var mousecoords = get_global_mouse_position()
		path = get_parent().get_node("Access").get_the_path(position, mousecoords)
		path.remove(0)
		

	if Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1

	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1


	if path:
		var target = path[0]
		direction = (target - position).normalized()
		position += cartesian_to_isometric(direction) * speed * delta
		
		if position.distance_to(target) < 5:
			path.remove(0)
			if path.size() == 0:
				path = null

"""
	if not is_moving and direction != Vector2():
		target_direction = direction.normalized()
		
		if direction == Vector2(-1,0):
			$AnimatedSprite.play("NW")
		elif direction == Vector2(1,0):
			$AnimatedSprite.play("SE")
		elif direction == Vector2(0,-1):
			$AnimatedSprite.play("NE")
		elif direction == Vector2(0,1):
			$AnimatedSprite.play("SW")
		
		if grid.is_cell_vacant(position, direction):
			target_pos = grid.update_child_pos(position, direction, 0)
			is_moving = true
	elif is_moving:
		speed = max_speed
		# We have to convert the player's motion to the isometric system.
		# The target_direction is normalized a few lines above so the player moves at the same speed in all directions.
		motion = cartesian_to_isometric(speed * target_direction * delta)

		var pos = position
		var distance_to_target = pos.distance_to(target_pos)
		var move_distance = motion.length()

		# In the previous example, the player could land on floating positions
		# We force him to stop exactly on the target by setting the position instead of using the move method
		# As the grid handles the "collisions", we can use the two functions interchangeably:
		# move(motion) <=> set_pos(get_pos() + motion)
		if move_distance > distance_to_target:
#			position = target_pos
			is_moving = false
		else:
			move_and_collide(motion)
#			move(motion)
"""
#	pass
