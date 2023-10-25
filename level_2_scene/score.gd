extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var object1 = null
var object2 = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if char_arr.size() == 2:
		object1 = char_arr[0]
		object2 = char_arr[1]
	if(score == 3):
		get_tree().change_scene_to_file(("res://Screens/win1.tscn"))

var score = 0
func _on_timer_timeout():
	score+=1
	text = str(score)
	object1.global_position = Vector2(20,-100)

var char_arr = []
func _on_level_2_char_to_add(char):

	char_arr.push_back(char)
