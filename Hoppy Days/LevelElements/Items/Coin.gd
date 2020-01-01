extends Node2D

var collected = false

func _on_Area2D_body_entered(body):
	if not collected:
		get_tree().call_group("GameState", "add_score", 1)
		$AnimationPlayer.play("die")
		$CoinSFX.play()
		collected = true

func die():
	queue_free()