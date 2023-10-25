extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_single_player_pressed():
	Global.single_player = true

	get_tree().change_scene_to_file(("res://Screens/player_select_1p.tscn"))


func _on_two_player_pressed():
	Global.single_player = false
	get_tree().change_scene_to_file(("res://Screens/player_select.tscn"))


func _on_online_pressed():
	Global.single_player = false
	Global.online = true
	get_tree().change_scene_to_file(("res://online/control.tscn"))
