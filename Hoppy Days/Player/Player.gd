extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 1500
const GRAVITY = 300
const UP = Vector2(0,-1)
const JUMP_SPEED = 4000

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
	if not is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = 5

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
