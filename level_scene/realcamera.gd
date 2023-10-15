extends Camera2D

var object1: Node = null
var object2: Node = null
var object3: Node = null
var initial_distance: float = 0.0

var shake_amount: float = 0
var default_offset: Vector2 = offset

var is_shaking: bool = false
var shake_duration: float = 0
#var shake_timer: Timer = Timer.new()
@export var timer : Timer
@export var shake_timer : Timer

func _ready():
	set_process(true)
	Global.camera = self
	object1 = get_node("../player")
	object2 = get_node("../enemy")
	object3 = get_node(".")

	initial_distance = calculate_initial_distance()

func _process(delta):
	if is_shaking:
		offset = calculate_shake_offset()
	else:
		offset = Vector2(0,0)


	var current_distance = calculate_current_distance()
	update_zoom(current_distance)

	# Set the camera position to the midpoint between object1 and object2
	update_camera_position(current_distance)

func calculate_initial_distance() -> float:
	if object2 != null:
		return object1.global_position.distance_to(object2.global_position)
	else:
		return object1.global_position.distance_to(object3.global_position)

func calculate_current_distance() -> float:
	var current_distance = 0.0
	if object1 != null:
		if object2 != null:
			current_distance = object1.global_position.distance_to(object2.global_position)
		else:
			current_distance = object1.global_position.distance_to(object3.global_position)
	else:
		if object2 != null:
			current_distance = object3.global_position.distance_to(object2.global_position)
	return current_distance

func update_zoom(current_distance: float):
	var zoom_factor = 1.0  # Default zoom factor if current_distance is 0
	if current_distance != 0.0:
		zoom_factor = initial_distance / current_distance
	# Limit the zoom factor within a specific range (e.g., 0.5 to 1.8)
	zoom_factor = clamp(zoom_factor, 0.5, 1.8)
	self.zoom = Vector2(zoom_factor, zoom_factor)

func update_camera_position(current_distance: float):
	if object1 != null:
		if object2 != null:
			object3.position = (object1.global_position + object2.global_position) / 2
		else:
			object3.position = (object1.global_position + object3.global_position) / 2
	else:
		if object2 != null:
			object3.position = (object3.global_position + object2.global_position) / 2
		else:
			object3.position = object3.global_position

func calculate_shake_offset() -> Vector2:
	return Vector2(randf_range(-1, 1) * shake_amount, randf_range(-1, 1) * shake_amount)

func shake(time: float, amount: float):
	is_shaking = true
	shake_timer.wait_time = time
	shake_amount = amount
	default_offset = offset  # Store the default offset
	shake_timer.start()

#func _on_timer_timeout():
#	is_shaking = false
#	offset = default_offset  # Reset to the default offset after the shake is finished
#	print("Shake timer timed out")


func _on_shake_timer_timeout():
	is_shaking = false
	offset = default_offset  # Reset to the default offset after the shake is finished
	print("Shake timer timed out")
