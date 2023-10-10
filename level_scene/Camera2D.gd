extends Camera2D
var object1 = null
var object2= null

func _ready():
	object1 = get_node("player")
	object2 = get_node("enemy")

func _process(delta):
	self.global_position = (object1.global_position + object2.global_position) * 0.5

	var zoom_factor1 = abs(object1.global_position.x-object2.global_position.x)/(1920-100)
	var zoom_factor2 = abs(object1.global_position.y-object2.global_position.y)/(1080-100)
	var zoom_factor = max(max(zoom_factor1, zoom_factor2), 0.5)

	self.zoom = Vector2(zoom_factor, zoom_factor)
