extends State
@export var return_state : State
@export var return_animation_node : String = "jump_start"
@export var ground_state : State
@export var ground_animation_node : String = "Move"
@export var grappled_node : String = "grappled"
@onready var hook = preload("res://projectiles/Chain.tscn")
@export var player : Player
@export var shoot_state : State
@export var shoot_animation : String = "shoot"


func _ready(): #get grapple states - kinda fucked rn will come back.
	player.connect("character_hooked", _grapple)

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
	if(event.is_action_pressed("shoot")):
		print("shit pressed")
		next_state = shoot_state
		playback.travel(shoot_animation)

