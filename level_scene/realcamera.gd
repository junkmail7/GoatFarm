extends Camera2D

var object1 = null
var object2 = null
var object3 = null
var initial_distance = 0.0 # Store the initial distance between object1 and object2

func _ready():
	object1 = get_node("../player")
	object2 = get_node("../enemy")
	object3 = get_node(".")
	
	initial_distance = calculate_initial_distance()

func _process(delta):
	var current_distance = 0.0
	
	if object1 != null:
		if object2 != null:
			current_distance = object1.global_position.distance_to(object2.global_position)
		else:
			current_distance = object1.global_position.distance_to(object3.global_position)
	else:
		if object2 != null:
			current_distance = object3.global_position.distance_to(object2.global_position)
		else:
			current_distance = 0.0  # If both object1 and object2 are null, set current_distance to 0
	
	var zoom_factor = 1.0  # Default zoom factor if current_distance is 0
	if current_distance != 0.0:
		zoom_factor = initial_distance / current_distance
	
	# Limit the zoom factor within a specific range (e.g., 0.5 to 1.8)
	zoom_factor = clamp(zoom_factor, 0.5, 1.8)
	
	self.zoom = Vector2(zoom_factor, zoom_factor)
	
	# Set the camera position to the midpoint between object1 and object2
	if object1 != null:
		if object2 != null:
			object3.position = (object1.global_position + object2.global_position) / 2
		else:
			object3.position = (object1.global_position + object3.global_position) / 2
	else:
		if object2 != null:
			object3.position = (object3.global_position + object2.global_position) / 2
		# If both object1 and object2 are null, keep the camera at the position of object3
		else:
			object3.position = object3.global_position


func calculate_initial_distance() -> float:
	if object2 != null:
		return object1.global_position.distance_to(object2.global_position)
	else:
		return object1.global_position.distance_to(object3.global_position)



#extends Camera2D
#
#var object1 = null
#var object2 = null
#var object3 = null
#var initial_distance = 0.0 # Store the initial distance between object1 and object2
#
#func _ready():
#	object1 = get_node("../player")
#	object2 = get_node("../enemy")
#	object3 = get_node(".")
#
#	initial_distance = object1.global_position.distance_to(object2.global_position)
#
#func _process(delta):
#	var current_distance = object1.global_position.distance_to(object2.global_position)
#	var zoom_factor = initial_distance / current_distance
#
#	# Limit the zoom factor within a specific range (e.g., 0.5 to 2.0)
#	zoom_factor = clamp(zoom_factor, 0.5, 1.8)
#
#	self.zoom = Vector2(zoom_factor, zoom_factor)
#
#	# Set the camera position to the midpoint between object1 and object2
#	object3.position = (object1.global_position + object2.global_position) / 2
	
