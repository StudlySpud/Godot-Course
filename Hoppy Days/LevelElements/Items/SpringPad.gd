extends Area2D



func _on_SpringPad_body_entered(body):
	$AnimationPlayer.play("boost")
	if body.has_method("boost"):
		body.boost()