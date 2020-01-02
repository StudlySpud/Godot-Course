extends "res://Characters/CharacterTemplate.gd"

var motion = Vector2()

func _physics_process(delta):
	look_at(get_global_mouse_position())
	update_movement(delta)
	move_and_slide(motion)


func update_movement(delta):
	if Input.is_action_pressed("move_up"):
		motion.y -= SPEED
	elif Input.is_action_pressed("move_down"):
		motion.y += SPEED
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
		
	if Input.is_action_pressed("move_left"):
		motion.x -= SPEED
	elif Input.is_action_pressed("move_right"):
		motion.x += SPEED
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
	
	motion.y = clamp (motion.y, -MAX_SPEED, MAX_SPEED)
	motion.x = clamp (motion.x, -MAX_SPEED, MAX_SPEED)
	