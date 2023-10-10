extends Label

@export var timer : Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(timer.time_left)
