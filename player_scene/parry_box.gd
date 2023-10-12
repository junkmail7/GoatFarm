extends Area2D

@onready var player = get_owner()
@export var facing_collision_shape : PlayerParryFaceDir

func _ready():
	monitoring = false
	player.connect("facing_direction_changed", _on_character_body_2d_facing_direction_changed)

func _on_body_entered(body):
	#print(body)
	for child in body.get_children():
		print(child)
		if child is EnemyParryable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			print(child)
			if(direction_sign > 0):
				child.parry(Vector2.RIGHT)
			elif(direction_sign < 0):
				child.parry(Vector2.LEFT)
			else:
				child.parry(Vector2.UP)		
		elif child is SuperParryable:
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			print(child)
			if(direction_sign > 0):
				child.superparry(Vector2.RIGHT)
			elif(direction_sign < 0):
				child.superparry(Vector2.LEFT)
			else:
				child.superparry(Vector2.UP)		

func _on_character_body_2d_facing_direction_changed(facing_right):
	if(facing_right):
		facing_collision_shape.position = facing_collision_shape.facing_right_position
	else:
		facing_collision_shape.position = facing_collision_shape.facing_left_position





#func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
#	for child in area.get_children():
#		print(child)
#		if child is Parryable:
#			var direction_to_damageable = (area.global_position - get_parent().global_position)
#			var direction_sign = sign(direction_to_damageable.x)
#			print(child)
#			if(direction_sign > 0):
#				child.parry(Vector2.RIGHT)
#			elif(direction_sign < 0):
#				child.parry(Vector2.LEFT)
#			else:
#				child.parry(Vector2.UP)		



