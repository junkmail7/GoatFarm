extends AnimatedSprite2D
@export var enemy : Enemy
@export var hurt_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	if(enemy.character_state_machine.current_state == hurt_state):
#		self.visible = true
#		self.play("default")
#	else:
#		self.visible = false
#		self.stop()		



func _on_damageable_on_hit(node, damage_taken, knockback_direction):
	self.visible = true
	self.play("default")


func _on_animation_finished():
	self.visible = false
	self.stop()
