extends Node

class_name Player_Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

@export var player : Player

@export var timer : Timer

@export var health : float = 50:
	get:
		return health
	set(value):
		
		#SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value

@export var dead_animation_name : String = "dead"

func hit(damage : int, knockback_direction : Vector2):
#	health -= damage
	print("player_hit")
	frameFreeze(0.05, 0.5)
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	
	#if(health <=0):
	#	get_parent().queue_free()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		timer.start()


func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	await(get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1


func _on_timer_timeout():
	player.global_position = Vector2(20,-100)
