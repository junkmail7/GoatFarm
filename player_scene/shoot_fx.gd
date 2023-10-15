extends GPUParticles2D

@export var player : Player
@export var shoot_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(shoot_state)
	if(player.state_machine.current_state == shoot_state):
		self.emitting = true
	else:
		self.emitting = false
		
	#if player.face_dir == true:
	
