extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 1500
const GRAVITY = 150
const UP = Vector2(0,-1)
const JUMP_SPEED = 2750
const BOOST_MULTIPLIER = 1.6

#When the player falls down to this Y absolute position, he is detected as fallen off the map
const WORLD_MAX_FALL_LIMIT = 4000

var isHurt = false

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
		get_tree().call_group("GameState", "end_game")
	elif is_on_floor() and motion.y > 0:
		isHurt = false
		motion.y = 0
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
		$JumpSFX.play()

func animate():
	emit_signal("animate", motion, isHurt)
	
func hurt():
	isHurt = true;
	position.y -= GRAVITY
	yield(get_tree(), "idle_frame") #this will force the script to do nothing until next frame
	motion.y =- JUMP_SPEED #Note the absolute setting, not just subtracting!  Or you could double jump by landing on a spike
	$PainSFX.play()

func boost():
	position.y -= GRAVITY
	yield(get_tree(), "idle_frame")
	motion.y =- (JUMP_SPEED*BOOST_MULTIPLIER)
	$JumpSFX.play()