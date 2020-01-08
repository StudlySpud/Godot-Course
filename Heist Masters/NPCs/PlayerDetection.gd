extends "res://Characters/CharacterTemplate.gd"

export var FOV_Tolerance = 20
export var LOS_Distance = 300
export var FOV_Offsets = {"angle":0, "X":0, "Y":0}

const RED = Color(1,0.25,0.25)
const WHITE = Color(1,1,1)

var Player

func _ready():
	Player = get_node("/root").find_node("Player", true, false)
	

func _process(delta):
	if Player_in_FOV() and Player_in_LOS(): 
		$Torch.color = RED
	else:
		$Torch.color = WHITE
	

func Player_in_FOV():
	var npc_facing_direction = (Vector2(1,0).rotated(global_rotation)).rotated(deg2rad(-FOV_Offsets["angle"]))
	var direction_to_Player = (Player.position - (global_position-Vector2(FOV_Offsets["X"], FOV_Offsets["Y"]))).normalized()
	
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_Tolerance):
		return true
	else:
		return false

func Player_in_LOS():
	pass
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray((global_position-Vector2(FOV_Offsets["X"], FOV_Offsets["Y"])), Player.global_position, [self], collision_mask)
	if not LOS_obstacle: #error checking
		return false
	
	var distance_to_player = Player.global_position.distance_to((global_position-Vector2(FOV_Offsets["X"], FOV_Offsets["Y"])))
	if (LOS_obstacle.collider == Player) and distance_to_player <= LOS_Distance:
		return true
	else:
		return false
	