extends CharacterBody2D

var speed = 70


var player_chase = false
var player = null

var health = 200
var player_inattack_zone = false

var can_take_damage = true


func _physics_process(delta):
	
	deal_with_damage()
	
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("run")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		$AnimatedSprite2D.play("Idle")
		
	


func _on_player_find_body_entered(body):
	player = body
	player_chase = true

func _on_player_find_body_exited(body):
	player =  null
	player_chase = false


func boss():
	pass


func _on_hittyboxy_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_hittyboxy_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage:
			health -= 20
			$attack_cooldown.start()
			can_take_damage = false
			print("boss health - ", health)
			if health <= 0:
				self.queue_free()


func _on_attack_cooldown_timeout():
	can_take_damage = true
