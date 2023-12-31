extends State
@export var return_state : State
@export var return_animation_node : String = "jump_start"
@export var ground_state : State
@export var ground_animation_node : String = "walk"
@export var grappled_node : String = "grappled"
@export var enemy : Enemy
@export var shoot_state : State
@export var shoot_animation : String = "shoot"

@export var reload : Timer

func _ready(): #get grapple states - kinda fucked rn will come back.
	enemy.connect("character_hooked", _grapple)

var is_hooked = false
func state_process(delta):
	if(!is_hooked && !character.is_on_floor()): #
		next_state = return_state
		playback.travel(return_animation_node)
		#player.disconnect("character_hooked", _grapple)
		print_debug("stop grappled anim air")
	elif(!is_hooked && character.is_on_floor()):
		next_state = ground_state
		playback.travel(ground_animation_node)
		#player.disconnect("character_hooked", _grapple)
		print_debug("stop grappled anim floor")
	
func _grapple(hooked):
	is_hooked = hooked
	#print(is_hooked)
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("p2_shoot")):
		if(Global.p2_ammo <= 0 && reload.is_stopped()):
			reload.start()
			print("start relaod")
		elif(Global.p2_ammo > 0):
			Global.camera.shake(0.1,10)
			next_state = shoot_state		
			playback.travel(shoot_animation)



func _on_reload_timeout():
	Global.p2_ammo = 2
