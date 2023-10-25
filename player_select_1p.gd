extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_2_pressed():
	Global.p1_char = 2


func _on_button_pressed():
	Global.p1_char = 1


func _on_button_3_pressed():
	get_tree().change_scene_to_file(("res://level_2_scene/level_2.tscn"))
