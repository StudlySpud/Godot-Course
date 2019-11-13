extends Control

var player_words = []
var template = [
		{
		"prompts" : ["a name", "a noun", "an adjective", "another adjective"],
		"story" : "%s had a %s and it was %s, he felt %s"
		},
		{
		"prompts" : ["an adjective", "a noun", "a verb", "an adjective", "a noun", "a name"],
		"story" : "A %s %s went and %s a %s %s named %s"
		},
		{
		"prompts" : ["an adjective", "a name", "a noun", "another noun"],
		"story" : "Once a %s wizard named %s needed to find a mystical %s to fix his %s"
		}
		]

var current_story

onready var PlayerText = $VBoxContainer/HBoxContainer/InputText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	pick_current_story()
	DisplayText.text = "Create a story!  "
	check_player_words_length()

func pick_current_story():
	randomize()
	current_story = template[randi() % template.size()]

func _on_Button_pressed():
	if is_story_done():
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

# warning-ignore:unused_argument
func _on_InputText_text_entered(new_text):
	add_to_player_words()

func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()

func is_story_done():
	return player_words.size() == current_story.prompts.size()

func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + "."
	PlayerText.grab_focus()

func end_game():
	tell_story()
	PlayerText.queue_free()
	$VBoxContainer/HBoxContainer/Label.text = "Again!"