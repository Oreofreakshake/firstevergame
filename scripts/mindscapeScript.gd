extends Node


func _process(delta):
	change_scene()

func _on_world_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true


func _on_world_transition_body_exited(body):
	if body.has_method("player"):
			global.transition_scene = false


func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "mindscape":
			get_tree().change_scene_to_file("res://scenes/Menus/endMenu.tscn")
			global.finish_changescene()




