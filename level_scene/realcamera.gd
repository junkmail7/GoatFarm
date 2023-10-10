extends Camera2D
var object1 = null
var object2= null
var object3 = null

func _ready():
	object1 = get_node("../player")
	object2 = get_node("../enemy")
	object3 = get_node(".")
	
	print(object1)

func _process(delta):
	object3.position = (object1.global_position + object2.position) * 0.5

	var zoom_factor1 = abs(object1.position.x-object2.position.x)/(1920)
	var zoom_factor2 = abs(object1.position.y-object2.position.y)/(1080)
	var zoom_factor = max(max(zoom_factor1, zoom_factor2), 0.5)
	#print(zoom_factor1)
	self.zoom = Vector2(zoom_factor, zoom_factor)
	#print(self.zoom)
