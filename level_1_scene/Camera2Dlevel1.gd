extends Camera2D

var object1: Node = null
var object2: Node = null
var object3: Node = null
var initial_distance: float = 0.0

var shake_amount: float = 0
var default_offset: Vector2 = offset

var is_shaking: bool = false
var shake_duration: float = 0

@export var timer : Timer
@export var shake_timer : Timer

func _ready():
	_on_tree_entered()

func _on_tree_entered():
	Global.camera = self
	object3 = get_node(".")
	
	set_process(true)

func _process(delta):
	if char_arr.size() == 2:
		object1 = char_arr[0]
		object2 = char_arr[1]
		if initial_distance == 0:
			initial_distance = calculate_initial_distance()

	if is_shaking:
		offset = calculate_shake_offset()
	else:
		offset = Vector2(0,0)

	var current_distance = calculate_current_distance()
	update_zoom(current_distance)

	# Set the camera position to the midpoint between object1 and object2
	update_camera_position(current_distance)

func calculate_initial_distance() -> float:
	if char_arr.size() >= 2:
		return char_arr[0].global_position.distance_to(char_arr[1].global_position)
	return 0.0 # Return a default distance if any of the objects is null

func calculate_current_distance() -> float:
	var current_distance = 0.0
	if object1 != null and object2 != null:
		current_distance = object1.global_position.distance_to(object2.global_position)
	elif object1 != null and object3 != null:
		current_distance = object1.global_position.distance_to(object3.global_position)
	elif object2 != null and object3 != null:
		current_distance = object3.global_position.distance_to(object2.global_position)
	
	return current_distance

func update_zoom(current_distance: float):
	var zoom_factor = 1.0  # Default zoom factor if current_distance is 0

	# Adjust zoom based on distance between characters
	if current_distance != 0.0 and initial_distance != 0.0:
		zoom_factor = clamp(initial_distance / current_distance, 0.5, 1.8)

	self.zoom = Vector2(zoom_factor, zoom_factor)

func update_camera_position(current_distance: float):
	if object1 != null and object2 != null:
		object3.position = (object1.global_position + object2.global_position) / 2
	elif object1 != null and object3 != null:
		object3.position = (object1.global_position + object3.global_position) / 2
	elif object2 != null and object3 != null:
		object3.position = (object3.global_position + object2.global_position) / 2

func calculate_shake_offset() -> Vector2:
	return Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)

func shake(time: float, amount: float):
	is_shaking = true
	shake_timer.wait_time = time
	shake_amount = amount
	default_offset = offset  # Store the default offset
	shake_timer.start()

func _on_shake_timer_timeout():
	is_shaking = false
	offset = default_offset  # Reset to the default offset after the shake is finished
	print("Shake timer timed out")

var char_arr = []

func _on_timer_2_timeout():
	pass # Replace with function body.


func _on_level_1_char_to_add(char):
	char_arr.push_back(char)
