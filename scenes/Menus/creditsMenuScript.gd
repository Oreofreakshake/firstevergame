extends MarginContainer


@onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer4/VBoxContainer/CenterContainer/HBoxContainer/selector


var current_selection = 0

func _ready():
	set_current_selection(0)
	
	
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		handle_selection(current_selection)
	
	
func handle_selection(_current_selection):
	if _current_selection == 0:
		get_tree().change_scene_to_file("res://scenes/Menus/mainMenu.tscn")
		queue_free()


func set_current_selection(_current_selection):
	selector_one.text = ""


	if _current_selection == 0:
		selector_one.text = ">"

