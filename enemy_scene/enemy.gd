extends CharacterBody2D

class_name Enemy

@onready var animation_tree : AnimationTree = $AnimationTree
@export var starting_move_direction : Vector2 = Vector2.LEFT
@onready var character_state_machine : CharacterStateMachine = $CharacterStateMachine
@export var friction : float = 270.0
@export var acceleration : float = 350.0
@export var SPEED = 350.0
@export var hit_state : State
@onready var sprite : Sprite2D = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

const CHAIN_PULL = 10
var chain_velocity := Vector2(0,0)

var can_grab = true

var face_dir = false

signal facing_direction_changed(facing_right : bool)
signal character_hooked(hooked : bool)

var smartguy = false


func _ready():
	animation_tree.active = true
		
func _physics_process(delta):
	#print(smartguy)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	direction = Input.get_vector("p2_left", "p2_right", "p2_up", "p2_down")
	
	if direction.x != 0 && character_state_machine.check_if_can_move():
		velocity.x = move_toward(velocity.x, SPEED * direction.x, acceleration * delta)
	elif(smartguy == true) && (face_dir == true):
		velocity += Vector2(-20,-5)
		smartguy == false
	elif(smartguy == true) && (face_dir == false):
		velocity += Vector2(20,-5)
		smartguy == false
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters():
	animation_tree.set("parameters/walk/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false

	elif direction.x < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)

func _on_facing_direction_changed(facing_right):
	face_dir = facing_right 
