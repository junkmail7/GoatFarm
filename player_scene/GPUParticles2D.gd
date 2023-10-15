extends GPUParticles2D
@export var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player && player.is_on_floor() && ((player.velocity.x > 150)||(player.velocity.x < -150)):
		self.emitting = true
	else:
		self.emitting = false
		
	if player.face_dir == true:
		self.process_material.set("direction", Vector3(1, 1, 0))
	else:
		self.process_material.set("direction", Vector3(-1, 1, 0))
