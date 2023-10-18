extends Label

@export var timer2 : Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(timer2.time_left)
