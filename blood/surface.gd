extends CanvasItem

var blood_color : Color = Color(0.5, 0, 0, 1.0)
var blood_thickness : float = 2.0
var blood_trails : Array = []

func draw_blood(draw_pos: Vector2, blood_length: float) -> void:
	#var local_pos = global_transform.affine_inverse().xform(draw_pos)
	var local_pos = to_local(draw_pos)
	print(local_pos)
	var end_pos = local_pos + Vector2(blood_length, 0)  # This creates a horizontal line; adjust as needed
	blood_trails.append({ "start": local_pos, "end": end_pos })  # Store the blood trail information
	queue_redraw()  # Request a redraw


  # Request a redraw

func _draw() -> void:
	for trail in blood_trails:
		draw_line(trail.start, trail.end, blood_color, blood_thickness)
#
#func _process(delta):
#	if Input.is_action_pressed("right_click"):
#		draw_blood(get_local_mouse_position(), 2.0)


func global_to_local(global_pos: Vector2) -> Vector2:
	var canvas = get_viewport().get_canvas_transform()
	return canvas.affine_inverse().basis_xform(global_pos)
	
func to_local(p_global):
	return get_global_transform().affine_inverse().basis_xform(p_global)
	











#class_name Paint
#
#var surface_image : Image = Image.create(1500, 1000, false, Image.FORMAT_RGBA8)
#var surface_texture : ImageTexture = ImageTexture.new()
#var blood_texture : ImageTexture = ImageTexture.new()
#var blood_image : Image = Image.new()
#
#func _ready() -> void:
#	# Fill the surface with a red color
#	surface_image.fill(Color(1.0, 0, 0, 1.0))
#	surface_texture.create_from_image(surface_image)
#	texture = surface_texture
#
#	# Load the blood image and create a texture from it
#	blood_image.load("res://gfx/blood1.png")
#	assert(blood_image.get_width() > 0 && blood_image.get_height() > 0, "Blood image failed to load.")
#	blood_texture.create_from_image(blood_image)
#
#func draw_blood(draw_pos : Vector2):
#	print("Drawing blood at position:", draw_pos)
#
#	# Blit the blood image onto the surface at the specified position
#	var source_rect = Rect2(Vector2(0, 0), Vector2(blood_image.get_width(), blood_image.get_height()))
#	surface_image.blit_rect(blood_image, source_rect, draw_pos)
#	surface_texture.create_from_image(surface_image)
#	texture = surface_texture
#
#func _physics_process(delta: float) -> void:
#	if(Input.is_action_pressed("right_click")):
#		draw_blood(get_global_mouse_position())
