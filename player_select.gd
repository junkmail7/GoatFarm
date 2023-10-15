extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#	get_tree().change_scene_to_file(("res://level_scene/level_fr.tscn"))


func _on_p_1_char_1_pressed():
	Global.p1_char = 1


func _on_p_1_char_2_pressed():
	Global.p1_char = 2


func _on_p_2_char_1_pressed():
	Global.p2_char = 1


func _on_p_2_char_2_pressed():
	Global.p2_char = 2


func _on_ready_pressed():
	print(Global.p1_char)
	get_tree().change_scene_to_file(("res://Screens/stage_select.tscn"))
