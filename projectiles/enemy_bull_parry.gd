extends Node

class_name EnemyParryable

signal on_parried(node : Node, knockback_direction : Vector2)


func parry(knockback_direction : Vector2):
	
	emit_signal("on_parried", get_parent(), knockback_direction)
	
	#after x time of bein parried, remove?
	#	get_parent().queue_free()
