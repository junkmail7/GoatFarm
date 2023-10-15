extends State

class_name AirState

@export var landing_state : State
@export var landing_animation : String = "jump_end"
@export var grapple_state : State
@export var grappling_animation : String = "grapple"
@export var shoot_state : State
@export var shoot_animation : String = "shoot"
@export var reload : Timer
#EX for setting physics and animations for aerial actions
#@export var double_jump_velocity : float = -100 
#@export var double_jump_animation : String = "double_jump"


func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state
		
#EX for performing aerial actions		
func state_input(event : InputEvent):
	if(event.is_action_pressed("grapple")):
		print_debug("air_grapple")
		next_state = grapple_state
	if(event.is_action_pressed("shoot")):
		if(Global.p1_ammo <= 0 && reload.is_stopped()):
			reload.start()
			print("start relaod")
		elif(Global.p1_ammo > 0):
			Global.camera.shake(0.1,10)
			print("shit pressed")
			next_state = shoot_state


func on_exit():
	if(next_state == landing_state):
		playback.travel(landing_animation)
	elif(next_state == grapple_state):
		playback.travel(grappling_animation)
	elif(next_state == shoot_state):
		playback.travel(shoot_animation)



func _on_reload_timeout():
	Global.p1_ammo = 2
