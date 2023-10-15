extends GPUParticles2D
@export var enemy : Enemy
@export var shoot_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(enemy.character_state_machine.current_state == shoot_state):
		self.emitting = true
	else:
		self.emitting = false

	if enemy.face_dir == true:
		self.process_material.set("direction", Vector3(1, 1, 0))
	else:
		self.process_material.set("direction", Vector3(-1, 1, 0))
