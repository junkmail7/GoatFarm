extends CharacterBody2D

class_name Player

@export var speed : float = 200.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var Chain : Node2D = $Chain

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

const CHAIN_PULL = 20
var chain_velocity := Vector2(0,0)

signal facing_direction_changed(facing_right : bool)
signal character_hooked(hooked : bool)

var smartguy = false

func _input(event: InputEvent) -> void: #Handle click for grapple, change to button combo
	if event is InputEventMouseButton:
		if event.pressed:
			# We clicked the mouse -> shoot()
			$Chain.shoot(event.position - get_viewport().size * 0.5)
		else:
			# We released the mouse -> release()
			$Chain.release()

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	#print(smartguy)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "ui_down")
	
	# Control whether to move or not to move
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	elif(smartguy == true) && (face_dir == true):
		velocity += Vector2(-20,-5)
		smartguy == false
	elif(smartguy == true) && (face_dir == false):
		velocity += Vector2(20,-5)
		smartguy == false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)


	if $Chain.hooked:
		update_hooked($Chain.hooked)
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		chain_velocity = to_local($Chain.tip).normalized() * CHAIN_PULL
		if chain_velocity.y > 0:
			# Pulling down isn't as strong
			chain_velocity.y *= 0.55
		else:
			# Pulling up is stronger
			chain_velocity.y *= 0.63
		if sign(chain_velocity.x) != sign(velocity.x):
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			chain_velocity.x *= 0.7
		if(smartguy == true):
			chain_velocity.x *= 2 
			chain_velocity.y *= 2 
	else:
		update_hooked(false)
		# Not hooked -> no chain velocity
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity


	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false

	elif direction.x < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
func update_hooked(hooked):
	emit_signal("character_hooked", hooked)
	

func _on_shoot_currently_shooting(shooting):
	smartguy = shooting

var face_dir = false
func _on_facing_direction_changed(facing_right):
	#print(facing_right)
	face_dir = facing_right # Replace with function body.
