extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 1500
const GRAVITY = 150
const UP = Vector2(0,-1)
const JUMP_SPEED = 2750

#When the player falls down to this Y absolute position, he is detected as fallen off the map
const WORLD_MAX_FALL_LIMIT = 4000

signal animate

func _ready():
	pass

func _physics_process(delta):
	apply_gravity()
	move()
	jump()
	animate()
	move_and_slide(motion, UP)

func apply_gravity():
	if position.y > WORLD_MAX_FALL_LIMIT:
		end_game()
	if is_on_floor():
		motion.y = 5
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY

func move():
	motion.x = 0
	if Input.is_action_pressed("left"):
		motion.x -= SPEED
	if Input.is_action_pressed("right"):
		motion.x += SPEED

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED

func animate():
	emit_signal("animate", motion)
	
	
func end_game():
	get_tree().change_scene("res://Scenes/Levels/GameOver.tscn")
