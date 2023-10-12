extends State

@export var dead_state : State
@export var dead_animation_node : String = "dead"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#



func _on_gib_hitbox_gibbed(gib):
	next_state = dead_state
	playback.travel(dead_animation_node)
