extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(score == 5):
		get_tree().change_scene_to_file(("res://Screens/win1.tscn"))

var score = 0
func _on_timer_timeout():
	score+=1
	text = str(score)
