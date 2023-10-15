extends RigidBody2D

var picked = false
var enemy_picked = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if picked == true:
		if (get_node("../player").face_dir):
			self.position = get_node("../player/throw_r").global_position
		else:
			self.position = get_node("../player/throw_l").global_position

	if enemy_picked == true:
		if (get_node("../enemy").face_dir):
			self.position = get_node("../enemy/throw_r").global_position
		else:
			self.position = get_node("../enemy/throw_l").global_position
	if is_parried:
		linear_velocity = parried_dir * 800
		is_parried = false		

		
func _input(event):
	if Input.is_action_just_pressed("grab_and_throw"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "player" and get_node("../player").can_grab == true:
				picked = true
	if Input.is_action_just_pressed("release") && picked == true && (get_node("../player").face_dir == true):
		linear_velocity = Vector2(800,-100)
		angular_velocity = 45.0
		picked = false
	if Input.is_action_just_pressed("release") && picked == true && (get_node("../player").face_dir == false):
		linear_velocity = Vector2(-800,-150)
		angular_velocity = 45.0
		picked = false
		
	if Input.is_action_just_pressed("p2_grab"):
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.name == "enemy" and get_node("../enemy").can_grab == true:
				enemy_picked = true
	if Input.is_action_just_pressed("p2_release") && enemy_picked == true && (get_node("../enemy").face_dir == true):
		print()
		linear_velocity = Vector2(800,-100)
		angular_velocity = 45.0
		enemy_picked = false
	if Input.is_action_just_pressed("p2_release") && enemy_picked == true && (get_node("../enemy").face_dir == false):
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
