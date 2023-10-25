extends State

class_name aiGroundState

@export var jump_velocity : float = -450.0
@export var air_state : State
@export var jump_animation : String = "jump_start"
@export var attack_state : State
@export var attack_animation : String = "attack"
@export var shoot_state : State
@export var shoot_animation : String = "shoot"
@export var grapple_state : State
@export var grapple_animation : String = "grapple"
@export var grab_state : State
@export var grab_animation : String = "grab"
@export var parry_state : State
@export var parry_animation : String = "parry"

@export var reload : Timer

func state_process(delta):
	# Check if the AI should jump based on its logic
	if character.is_on_floor() and should_ai_jump():
		character.velocity.y = jump_velocity
		next_state = air_state
		playback.travel(jump_animation)

func state_input(event: InputEvent):
	if (event.is_action_pressed("p2_attack")):
		attack()
	if (event.is_action_pressed("p2_shoot")):
		shoot()
	if (event.is_action_pressed("p2_grapple")):
		grapple()
	if (event.is_action_pressed("p2_grab")):
		grab()
	if (event.is_action_pressed("p2_parry")):
		parry()

func should_ai_jump() -> bool:
	# Calculate the direction vector from AI to player
	var direction_to_player = Global.p1_lokaysh - character.global_position

	# Check if the player is above the AI and within a certain X distance
	return direction_to_player.y < -100 and abs(direction_to_player.x) < 200


func attack():
	next_state = attack_state
	playback.travel(attack_animation)

func shoot():
	if (Global.p2_ammo <= 0 && reload.is_stopped()):
		reload.start()
		print("start reload")
	elif (Global.p2_ammo > 0):
		Global.camera.shake(0.1, 10)
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
	Global.p2_ammo = 2


