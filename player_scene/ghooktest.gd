extends Line2D

@export var player : Player
@onready var Chain : Node2D = $Chain
@export var grapple : State
@export var grappled : State
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($Tip.global_position = tip)
	if(player.state_machine.current_state == grapple) || (player.state_machine.current_state == grappled):
		add_point(Vector2(50,100))
	else:
		clear_points()
