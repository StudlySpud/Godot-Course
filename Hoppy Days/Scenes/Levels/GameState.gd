extends Node2D

var lives = 3
var score = 0
var coins_to_life = 10

var levels = [
	"res://Scenes/Levels/Level1.tscn",
	"res://Scenes/Levels/Level2.tscn"
]
var currentLevel = 0

func _ready():
	add_to_group("GameState")
	get_tree().call_group("GUI", "update_GUI", lives, score)

func hurt():
	lives -= 1
	$Player.hurt()
	print("Calling Group")
	get_tree().call_group("GUI", "update_GUI", lives, score)
	if lives < 0:
		end_game()

func add_score(coins):
	score += coins
	var multiple_of_coins = ((score % coins_to_life) == 0)
	if multiple_of_coins:
		lives += 1
	get_tree().call_group("GUI", "update_GUI", lives, score)


func next_level():
	currentLevel += 1
	get_tree().change_scene(levels[currentLevel])

func end_game():
	get_tree().change_scene("res://Scenes/Levels/GameOver.tscn")