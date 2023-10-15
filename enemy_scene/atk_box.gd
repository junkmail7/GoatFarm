extends Area2D

@export var damage : int = 10
@export var enemy : Enemy
@export var facing_collision_shape : FacingCollisionShapeEnemyAttack

func _ready():
	print(enemy)
	print(get_owner())
	monitoring = false
	#enemy.connect("facing_direction_changed", _on_snail_facing_direction_changed)
	
func _on_body_entered(body):
	print(monitoring)
	print("HIT")
	for child in body.get_children():
		print(child)
		if child is Player_Damageable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			
			if(direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif(direction_sign < 0):
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.UP)
		#print_debug(body.name + " took " + str(damage)) # Replace with function body.


func _on_snail_facing_direction_changed(facing_right):
	if(facing_right):
		facing_collision_shape.position = facing_collision_shape.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position


#func _on_timer_timeout():
#	set_monitoring(false)
