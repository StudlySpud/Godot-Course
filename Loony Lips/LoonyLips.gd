extends Control

var player_words = []
var story = "%s had a %s and it was %s, he felt %s"
var prompts = ["a name", "a noun", "an adjective", "another adjective"]

onready var PlayerText = $VBoxContainer/HBoxContainer/InputText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	DisplayText.text = "Create a story!  "
	check_player_words_length()


func _on_Button_pressed():
	add_to_player_words()

func _on_InputText_text_entered(new_text):
	add_to_player_words()

func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()

func is_story_done():
	return player_words.size() == prompts.size()

func check_player_words_length():
	if is_story_done():
		tell_story()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = story % player_words

func prompt_player():
	DisplayText.text += "May I have " + prompts[player_words.size()] + "."
