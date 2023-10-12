extends State

@export var return_state : State
@export var return_animation_node : String = "walk"
# Called when the node enters the scene tree for the first time.


func _on_animation_tree_animation_finished(anim_name):
	next_state = return_state
	playback.travel(return_animation_node)
