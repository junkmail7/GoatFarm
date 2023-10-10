extends Node

class_name SuperParryable

signal on_superparried(node : Node, knockback_direction : Vector2)


func superparry(knockback_direction : Vector2):
	
	emit_signal("on_superparried", get_parent(), knockback_direction)
	
	#after x time of bein parried, remove?
	#	get_parent().queue_free()
