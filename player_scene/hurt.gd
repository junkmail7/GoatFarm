extends State

class_name HitStatePlayer
# Called when the node enters the scene tree for the first time.
@export var dead_state : State
@export var damageable : Player_Damageable
@export var dead_animation_node : String = "dead"
@export var knockback_speed : float = 100.0
@export var return_state : State

@onready var timer : Timer = $Timer
func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_enter():
	print_debug("Knockback applied")	
	timer.start()

func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	print("HIT!")
	if(damageable.health > 0):
		if damage_amount > 5:	
			character.velocity = knockback_speed * knockback_direction * 4
		else:
			character.velocity = knockback_speed * knockback_direction	
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)
		
func on_exit(): #change velocity again after initial_knockback if needed?
	character.velocity = Vector2.ZERO

func _on_timer_timeout():
	print_debug("TIMER FUCKING STOPPED")
	next_state = return_state # Replace with function body.
