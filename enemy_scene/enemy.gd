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

func _input(event: InputEvent) -> void: 
	var direction = Vector2()
	direction.x = int(Input.is_action_pressed("p2_right")) - int(Input.is_action_pressed("p2_left"))
	direction.y = int(Input.is_action_pressed("p2_down")) - int(Input.is_action_pressed("p2_up"))
	
	if(event.is_action_pressed("p2_grapple") && !$chain.hooked):
		if event.pressed && (face_dir == true) && direction == Vector2(1, -1):
			$chain.shoot(Vector2(1,-1))#event.position - get_viewport().size * 0.5)
		elif event.pressed && (face_dir == true) && direction == Vector2(0, -1):
			$chain.shoot(Vector2(0,-1))
		elif event.pressed && (face_dir == true) && direction == Vector2(1, 0):
			$chain.shoot(Vector2(1, 0))
		elif event.pressed && (face_dir == true) && direction == Vector2(0, 0):
			$chain.shoot(Vector2(1, 0))
		elif event.pressed && (face_dir == true) && direction == Vector2(0, 1):
			$chain.shoot(Vector2(0,1))
		elif event.pressed && (face_dir == true) && direction == Vector2(1, 1):
			$chain.shoot(Vector2(1, 1))
			
		elif event.pressed && (face_dir == false) && direction == Vector2(-1, -1):
			$chain.shoot(Vector2(-1,-1))
		elif event.pressed && (face_dir == false) && direction == Vector2(0, -1):
			$chain.shoot(Vector2(0,-1))
		elif event.pressed && (face_dir == false) && direction == Vector2(-1, 0):
			$chain.shoot(Vector2(-1, 0))
		elif event.pressed && (face_dir == false) && direction == Vector2(0, 0):
			$chain.shoot(Vector2(-1, 0))
		elif event.pressed && (face_dir == false) && direction == Vector2(-1, 1):
			$chain.shoot(Vector2(-1, 1))
		elif event.pressed && (face_dir == false) && direction == Vector2(0, 1):
			$chain.shoot(Vector2(0, 1))
			
	if(event.is_action_pressed("p2_release")):
			$chain.release()

func _ready():
	animation_tree.active = true
	Global.p2_ammo = 2
		
func _physics_process(delta):
	#print(smartguy)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	direction = Input.get_vector("p2_left", "p2_right", "p2_up", "p2_down")
	
	if direction.x != 0 && character_state_machine.check_if_can_move():
		velocity.x = move_toward(velocity.x, SPEED * direction.x, acceleration * delta)
	elif(smartguy == true) && (face_dir == true):
		velocity += Vector2(-10,-5)
		smartguy == false
	elif(smartguy == true) && (face_dir == false):
		velocity += Vector2(10,-5)
		smartguy == false
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	if $chain.hooked:
		update_hooked($chain.hooked)
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		chain_velocity = to_local($chain.tip).normalized() * CHAIN_PULL
		if chain_velocity.y > 0:
			# Pulling down isn't as strong
			chain_velocity.y *= 1.55
		else:
			# Pulling up is stronger
			chain_velocity.y *= 1.63
		if sign(chain_velocity.x) != sign(velocity.x):
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			chain_velocity.x *= 0.7
		if(smartguy == true): #we shootin and grapplin
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
	animation_tree.set("parameters/walk/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false

	elif direction.x < 0:
		sprite.flip_h = true
	
	emit_signal("facing_direction_changed", !sprite.flip_h)

func _on_facing_direction_changed(facing_right):
	face_dir = facing_right 

func update_hooked(hooked):
	emit_signal("character_hooked", hooked)


func _on_shoot_currently_shooting(shooting):
	smartguy = shooting
