extends State

@export var dead_state : State
@export var return_animation_node : String = "walk"
@export var knockback_speed : float = 100.0
@export var return_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == "parry"):
		next_state = return_state
		playback.travel(return_animation_node)
		print_debug("stop parry")
