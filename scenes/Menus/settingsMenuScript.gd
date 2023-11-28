extends MarginContainer


@onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer/VBoxContainer/CenterContainer/HBoxContainer/selector
@onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/selector

var current_selection = 0

func _ready():
	set_current_selection(0)
	
	
func _process(delta):
	if Input.is_action_just_pressed("down") and current_selection < 1:
		$selectorsound.play()
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("up") and current_selection > 0:
		$selectorsound.play()
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("attack"):
		handle_selection(current_selection)	
	
	
func handle_selection(_current_selection):
	if _current_selection == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif _current_selection == 1:
		get_tree().change_scene_to_file("res://scenes/Menus/mainMenu.tscn")
		queue_free()



func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""

	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
