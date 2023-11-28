extends CharacterBody2D

var direction : Vector2 = Vector2()
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D


var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 160
var player_alive = true
var npc_in_range = false
var npc_mindscape_in_range = false

var boss_inattack_range = false
var boss_attack_cooldown = true

var attack_ip = false

func read_input():
	
	velocity = Vector2()
	
	if attack_ip == false:
		if Input.is_action_pressed("up"):
			velocity.y -= 1
			direction = Vector2(0,-1)

			
		if Input.is_action_pressed("down"):
			velocity.y += 1
			direction = Vector2(0,1)


		if Input.is_action_pressed("left"):
			velocity.x -= 1
			direction = Vector2(-1,0)
			switch_direction(true)


		
		if Input.is_action_pressed("right"):
			velocity.x += 1
			direction = Vector2(1,0)
			switch_direction(false)


		velocity = velocity.normalized()
	
		velocity = velocity * 90
	
		move_and_slide()

	
	
	update_animations(direction)
	
func update_animations(direction):
	if velocity.x or velocity.y != 0:
		ap.play("Run")
	else:
		if attack_ip == false:
			ap.play("Idle")
		
		
func switch_direction(is_Switch):
	sprite.flip_h = is_Switch
	if sprite.flip_h == is_Switch:
		sprite.position.x = direction[0] * 10
	


func _physics_process(delta):
		read_input()
		enemy_attack()
		boss_attack()
		attack()
		
		if health <= 0:
			player_alive = false
			health = 0
			print("player died")
			get_tree().change_scene_to_file("res://scenes/gameover.tscn")
			
		if npc_in_range:
			if Input.is_action_just_pressed("enter"):
				DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), "npc_interaction")
				return

		if npc_mindscape_in_range:
			if Input.is_action_just_pressed("enter"):
				DialogueManager.show_example_dialogue_balloon(load("res://dialogues/mindscape.dialogue"), "npc_interaction")
				return

		if global.current_scene == "world":
			if Input.is_action_just_pressed("enter"):
				DialogueManager.show_example_dialogue_balloon(load("res://dialogues/main.dialogue"), "start")
				return

		if global.current_scene == "mindscape":
			if Input.is_action_just_pressed("enter"):
				DialogueManager.show_example_dialogue_balloon(load("res://dialogues/mindscape.dialogue"), "start")
				return



func player():
	pass


func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattack_range = true
	elif body.has_method("boss"):
		boss_inattack_range = true
		

func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattack_range = false
	elif body.has_method("boss"):
		boss_inattack_range = true
		

		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health -= 20
		enemy_attack_cooldown = false
		$attackCooldown.start()
		print("my health - ",health)
		
func boss_attack():
	if boss_inattack_range and boss_attack_cooldown == true:
		health -= 20
		boss_attack_cooldown = false
		$bossAttackCooldown.start()
		print("my health - ",health)
		
		

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func _on_boss_attack_cooldown_timeout():
	boss_attack_cooldown = true

	
func attack():
	if Input.is_action_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		ap.play("Attack")
		$dealAttacktimer.start()
		
		
func _on_deal_attacktimer_timeout():
	$dealAttacktimer.stop()
	global.player_current_attack = false
	attack_ip = false


func _on_detection_area_body_entered(body):
	if body.has_method("npc"):
		npc_in_range = true
	elif body.has_method("npc_mindscape"):
		npc_mindscape_in_range = true


func _on_detection_area_body_exited(body):
	if body.has_method("npc"):
		npc_in_range = false
	elif body.has_method("npc_mindscape"):
		npc_mindscape_in_range = true


