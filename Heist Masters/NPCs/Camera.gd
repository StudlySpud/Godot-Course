extends Node2D

func _ready():
	randomize()
	var RandomStartPosition = rand_range(0, 12)
	$CameraBody/AnimationPlayer.advance(RandomStartPosition)
	
	