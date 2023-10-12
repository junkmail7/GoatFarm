extends State
@export var return_state : State
@export var return_animation_node : String = "walk"
@export var attack_node : String = "attack"
@onready var timer : Timer = $Timer


func state_input(event : InputEvent):
	if(event.is_action_pressed("p2_attack")) && timer:
		print_debug("button pressed")		
		if (timer.time_left > 0):  #account for multiple inputs while timer is running
			print_debug("attacking")
			timer.start()

func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == attack_node):
		print(anim_name)
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
			print_debug("stop attacking")
			

