extends Area2D

signal gibbed(gib : bool)

func _on_body_entered(body):
	#print(body)
	for child in body.get_children():
		print(child)
		if child is SuperParryable:
			if (child.get_parent().linear_velocity.x < 0):
				if(child.get_parent().linear_velocity.x < -300):
					print("dead_time")
					emit_signal("gibbed", true)
				
			else:
				if(child.get_parent().linear_velocity.x > 300):
					print("dead_time")
					emit_signal("gibbed", true)
					

