extends Control

func _ready():
	var prompts = ["Bob", "Bobs world", "shit"]
	
	var story = "%s watched %s and it was %s"
	
	#print(story % prompts)
	$DisplayText.text = story % prompts