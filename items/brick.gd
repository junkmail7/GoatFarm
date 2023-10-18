extends RigidBody2D

var picked = false
var enemy_picked = false
var object1 = null
var object2 = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if char_arr.size() == 2:
		object1 = char_arr[0]
		object2 = char_arr[1]
		#print(object1.get_node("throw_r").global_position)
		
	if picked == true:
		if (object1.face_dir):
			self.position = object1.get_node("throw_r").global_position
		else:
			self.position = object1.get_node("throw_l").global_position

	if enemy_picked == true:
		if (object2.face_dir):
			self.position = object2.get_node("throw_r").global_position
		else:
			self.position = object2.get_node("throw_l").global_position
	if is_parried:
		linear_velocity = parried_dir * 800
		is_parried = false		

		
func _input(event):
	if Input.is_action_just_pressed("grab_and_throw"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			for child in body.get_children():
				if (child is AudioListener2D) and object1.can_grab == true:
					picked = true
	if Input.is_action_just_pressed("release") && picked == true && (object1.face_dir == true):
		linear_velocity = Vector2(800,-100)
		angular_velocity = 45.0
		picked = false
	if Input.is_action_just_pressed("release") && picked == true && (object1.face_dir == false):
		linear_velocity = Vector2(-800,-150)
		angular_velocity = 45.0
		picked = false
		
	if Input.is_action_just_pressed("p2_grab"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			for child in body.get_children():
				if (child is RayCast2D) and object2.can_grab == true:
					enemy_picked = true
	if Input.is_action_just_pressed("p2_release") && enemy_picked == true && (object2.face_dir == true):
		print()
		linear_velocity = Vector2(800,-100)
		angular_velocity = 45.0
		enemy_picked = false
	if Input.is_action_just_pressed("p2_release") && enemy_picked == true && (object2.face_dir == false):
		print()
		linear_velocity = Vector2(-800,-150)
		angular_velocity = 45.0
		enemy_picked = false

var is_parried = false
var parried_dir = Vector2(0,0)

func _on_super_parryable_on_superparried(node, knockback_direction):
	is_parried = true
	parried_dir = knockback_direction
	print("tryna parry the brick")


var char_arr = []

func _on_level_2_char_to_add(char):

	char_arr.push_back(char)


func _on_level_1_char_to_add(char):
	char_arr.push_back(char)
