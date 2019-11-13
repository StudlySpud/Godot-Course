extends Control

var player_words = []
var current_story = {}

onready var PlayerText = $VBoxContainer/HBoxContainer/InputText
onready var DisplayText = $VBoxContainer/DisplayText

func _ready():
	pick_current_story()
	DisplayText.text = "Create a story!  "
	check_player_words_length()

func pick_current_story():
	randomize()
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story.prompts = $StoryBook.get_child(selected_story).prompts
	current_story.story = $StoryBook.get_child(selected_story).story

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