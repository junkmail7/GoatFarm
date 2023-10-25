extends Line2D

@export var player : Player
@export var chain : Node2D
@export var grapple : State
@export var grappled : State
var fixed_length = 50.0  # Adjust the desired fixed length
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(player.state_machine.current_state == grapple)
	if(player.state_machine.current_state == grapple) || (player.state_machine.current_state == grappled):
		var direction = chain.global_position - player.global_position
		var normalized_direction = direction.normalized()
		var second_point = player.global_position + normalized_direction * fixed_length
		points = [player.global_position, second_point]
	else:
		clear_points()
