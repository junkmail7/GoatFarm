extends CanvasItem

@export var timer : Timer

var blood_color : Color = Color(0.5, 0, 0, 1.0)
var blood_thickness : float = 2.0
var blood_trails : Array = []

func draw_blood(draw_pos: Vector2, blood_length: float) -> void:
	#var local_pos = global_transform.affine_inverse().xform(draw_pos)
	var local_pos = to_local(draw_pos)
	#print(local_pos)
	var end_pos = local_pos + Vector2(blood_length, 0)  # This creates a horizontal line; adjust as needed
	blood_trails.append({ "start": local_pos, "end": end_pos })  # Store the blood trail information
	queue_redraw()  # Request a redraw


  # Request a redraw

func _draw() -> void:
	for trail in blood_trails:
		draw_line(trail.start, trail.end, blood_color, blood_thickness)
		timer.start()
#
#func _process(delta):
#	if Input.is_action_pressed("right_click"):
#		draw_blood(get_local_mouse_position(), 2.0)


func global_to_local(global_pos: Vector2) -> Vector2:
	var canvas = get_viewport().get_canvas_transform()
	return canvas.affine_inverse().basis_xform(global_pos)
	
func to_local(p_global):
	return get_global_transform().affine_inverse().basis_xform(p_global)
	

func _on_timer_timeout():
	print("tima cleared")
	blood_trails.clear()  # Clear the blood_trails array
	queue_redraw()  
