extends CanvasItem  # or Node2D

# You can add some properties to control the appearance of the blood
var blood_color : Color = Color(1.0, 0, 0, 1.0)
var blood_thickness : float = 2.0

func draw_blood(draw_pos: Vector2, blood_length: float):
	# Determine the end position based on the length of the blood
	var end_pos = draw_pos + Vector2(blood_length, 0)  # This creates a horizontal line; adjust as needed
	
	# Draw a line representing the blood
	draw_line(draw_pos, end_pos, blood_color, blood_thickness)
