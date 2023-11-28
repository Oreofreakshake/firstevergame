extends Node


var player_current_attack = false

var current_scene = "world"
var transition_scene = false
var answer_right = false

var slimes_defeated = false 


var player_exit_mindscape_posx = 0
var player_exit_mindscape_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func finish_changescene():
	if transition_scene:
		transition_scene = false
		if current_scene == "world":
			current_scene = "mindscape"
		else:
			current_scene = "world"
