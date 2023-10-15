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
@export var grab_state : State
@export var grab_animation : String = "grabitem"
@export var parry_state : State
@export var parry_animation : String = "parry"
@export var reload_sound : AudioStreamPlayer2D
@export var reload : Timer

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
	if(event.is_action_pressed("grapple")):
		grapple()
	if(event.is_action_pressed("grab_and_throw")):
		grab()
	if(event.is_action_pressed("parry")):
		parry()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_animation)

func shoot():
	print(Global.p1_ammo)
	if(Global.p1_ammo <= 0 && reload.is_stopped()):
		reload.start()
		reload_sound.play()
		print("start relaod")
	elif(Global.p1_ammo > 0):
		Global.camera.shake(0.1,10)
		next_state = shoot_state		
		playback.travel(shoot_animation)

func grapple():
	next_state = grapple_state
	playback.travel(grapple_animation)

func grab():
	next_state = grab_state
	playback.travel(grab_animation)

func parry():
	next_state = parry_state
	playback.travel(parry_animation)


func _on_reload_timeout():
	Global.p1_ammo = 2
