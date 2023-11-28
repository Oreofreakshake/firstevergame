extends Node


@export var enemy_scenes: Array[PackedScene] = [] 

@onready var timer = $enemyspawn_timer
@onready var enemyContainer = $enemycontainer

var MaxEnemy = 3
var TotalEnemy = 0



func _process(delta):
	change_scene()

func _on_enemyspawn_timer_timeout():
	var enemy = enemy_scenes.pick_random().instantiate()

	enemy.global_position = Vector2(randf_range(150, 250),randf_range(200,300))

	if TotalEnemy != MaxEnemy:
		enemyContainer.add_child(enemy)
		TotalEnemy += 1
		global.slimes_defeated = false
	else:
		global.slimes_defeated = true



func _on_mindscape_transition_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true


func _on_mindscape_transition_body_exited(body):
		if body.has_method("player"):
			global.transition_scene = false
			
func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/mindscape.tscn")
			global.finish_changescene()
