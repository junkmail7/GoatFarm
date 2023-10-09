extends State

class_name GroundState

@export var jump_velocity : float = -450.0
@export var air_state : State
@export var jump_animation : String = "jump_start"
@export var attack_state : State
@export var attack_animation : String = "attack1"
@export var shoot_state : State
@export var shoot_animation : String = "shoot"
@export var grapple_state : State
@export var grapple_animation : String = "grapple"

func state_process(delta):
	if(!character.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	if(event.is_action_pressed("attack")):
		attack()
	if(event.is_action_pressed("shoot")):
		shoot()
	if event is InputEventMouseButton:
		grapple()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_animation)

func shoot():
	next_state = shoot_state
	playback.travel(shoot_animation)

func grapple():
	next_state = grapple_state
	playback.travel(grapple_animation)
