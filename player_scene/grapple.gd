extends State
@export var return_state : State
@export var return_animation_node : String = "Move"
@export var air_state : State
@export var air_animation_node : String = "jump_start"
@export var grappled_state : State
@export var grappled_animation_node : String = "grappled"
@export var grapple_node : String = "grapple"
@onready var hook = preload("res://projectiles/Chain.tscn")
@onready var timer : Timer = $Timer
@onready var ray : RayCast2D = $RayCast2D
@export var player : Player

func _ready(): 
	player.connect("character_hooked", _grapple)
	
var is_hooked = false

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == grapple_node):
		print(anim_name)
		if(!is_hooked && character.is_on_floor()):
			next_state = return_state
			playback.travel(return_animation_node)
			#player.disconnect("character_hooked", _grapple)
			print_debug("stop grapple")
		elif(!is_hooked && !character.is_on_floor()):
			next_state = air_state
			playback.travel(air_animation_node)
			#player.disconnect("character_hooked", _grapple)
			print_debug("stop grapple")
		elif(is_hooked):
			next_state = grappled_state
			playback.travel(grappled_animation_node)

func _grapple(hooked):
	is_hooked = hooked
