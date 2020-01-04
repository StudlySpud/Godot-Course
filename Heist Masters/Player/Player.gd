extends "res://Characters/CharacterTemplate.gd"

var motion = Vector2()

var ZOOM_SCALE = 0.05

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
	

func _input(event):
	if Input.is_action_just_pressed("torch_toggle"):
		$Torch.enabled = !$Torch.enabled
	
	if Input.is_action_pressed("zoom_in"):
		$Camera2D.zoom.x -= ZOOM_SCALE
		$Camera2D.zoom.y -= ZOOM_SCALE
	elif Input.is_action_pressed("zoom_out"):
		$Camera2D.zoom.x += ZOOM_SCALE
		$Camera2D.zoom.y += ZOOM_SCALE
	
	$Camera2D.zoom.x = clamp ($Camera2D.zoom.x, 0.3, 1.5)
	$Camera2D.zoom.y = clamp ($Camera2D.zoom.y, 0.3, 1.5)
	
