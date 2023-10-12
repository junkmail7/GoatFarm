extends Node

class_name Player_Damageable

signal on_hit(node : Node, damage_taken : int, knockback_direction : Vector2)

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
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	
	#if(health <=0):
	#	get_parent().queue_free()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		get_parent().queue_free()
		

#
#func _on_gib_box_gibbed(gib):
#	get_parent().queue_free()


func _on_gib_hitbox_gibbed(gib):
	pass # Replace with function body.
