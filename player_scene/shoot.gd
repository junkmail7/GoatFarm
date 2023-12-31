extends State
@export var return_state : State
@export var return_animation_node : String = "Move"
@export var grappled_state : State
@export var grappled_animation_node : String = "grappled"
@export var shoot_node : String = "shoot"
@export var knockback_speed : float = 100.0
@onready var projectile = preload("res://projectiles/node_2d.tscn")
@onready var timer : Timer = $Timer
@export var player : Player
@export var gunshot : AudioStreamPlayer2D

signal currently_shooting(shooting : bool)

func _ready(): #get grapple states - kinda fucked rn will come back.
	player.connect("character_hooked", _grapple)
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("shoot")) && timer:
		print_debug("button pressed")
		if (timer.time_left > 0):  #account for multiple inputs while timer is running
			print_debug("shooting")
			timer.start()
			
func on_enter():
		gunshot.play()
		Global.p1_ammo -= 1
		update_shooting(true)
		var bullet = projectile.instantiate()	
		bullet.set_global_position(get_parent().get_parent().get_global_position())
		add_child(bullet)	
		#character.velocity = knockback_speed * Vector2.LEFT
		
var is_hooked = false
	
func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == shoot_node):

		print(anim_name)
		if(timer.is_stopped() && !is_hooked):
			next_state = return_state
			playback.travel(return_animation_node)
			print_debug("stop shooting")
		elif(timer.is_stopped() && is_hooked):
			next_state = grappled_state
			playback.travel(grappled_animation_node)
			print_debug("stop shooting")
		update_shooting(false)
			


func _grapple(hooked):
	is_hooked = hooked

func _on_character_body_2d_facing_direction_changed(facing_right):
	pass#print(facing_right)
	
func update_shooting(shooting):
	emit_signal("currently_shooting", shooting)

