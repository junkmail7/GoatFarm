extends CharacterBody2D

class_name Player

@export var speed : float = 350.0
@export var friction : float = 400.0
@export var acceleration : float = 370.0


@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var Chain : Node2D = $Chain

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

const CHAIN_PULL = 10
var chain_velocity := Vector2(0,0)

var can_grab = true

var face_dir = false

signal facing_direction_changed(facing_right : bool)
signal character_hooked(hooked : bool)

var smartguy = false

#func _input(event: InputEvent) -> void: #Handle click for grapple, change to button combo
#	if event is InputEventMouseButton:
#		if event.pressed:
#			# We clicked the mouse -> shoot()
#			$Chain.shoot(event.position - get_viewport().size * 0.5)
#		else:
#			# We released the mouse -> release()
#			$Chain.release()
			
func _input(event: InputEvent) -> void: 
	var direction = Vector2()
	direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	if(event.is_action_pressed("grapple") && !$Chain.hooked):
		if event.pressed && (face_dir == true) && direction == Vector2(1, -1):
			$Chain.shoot(Vector2(1,-1))#event.position - get_viewport().size * 0.5)
		elif event.pressed && (face_dir == true) && direction == Vector2(0, -1):
			$Chain.shoot(Vector2(0,-1))
		elif event.pressed && (face_dir == true) && direction == Vector2(1, 0):
			$Chain.shoot(Vector2(1, 0))
		elif event.pressed && (face_dir == true) && direction == Vector2(0, 0):
			$Chain.shoot(Vector2(1, 0))
		elif event.pressed && (face_dir == true) && direction == Vector2(0, 1):
			print("down")
			$Chain.shoot(Vector2(0,1))
		elif event.pressed && (face_dir == true) && direction == Vector2(1, 1):
			$Chain.shoot(Vector2(1, 1))

			
		elif event.pressed && (face_dir == false) && direction == Vector2(-1, -1):
			$Chain.shoot(Vector2(-1,-1))
		elif event.pressed && (face_dir == false) && direction == Vector2(0, -1):
			$Chain.shoot(Vector2(0,-1))
		elif event.pressed && (face_dir == false) && direction == Vector2(-1, 0):
			$Chain.shoot(Vector2(-1, 0))
		elif event.pressed && (face_dir == false) && direction == Vector2(0, 0):
			$Chain.shoot(Vector2(-1, 0))
		elif event.pressed && (face_dir == false) && direction == Vector2(-1, 1):
			$Chain.shoot(Vector2(-1, 1))
		elif event.pressed && (face_dir == false) && direction == Vector2(0, 1):
			$Chain.shoot(Vector2(0, 1))
			
	if(event.is_action_pressed("release")):
			$Chain.release()

func _ready():
	animation_tree.active = true
	Global.p1_ammo = 2

func _physics_process(delta):
	#print(smartguy)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = move_toward(velocity.x, speed * direction.x, acceleration * delta)
	elif(smartguy == true) && (face_dir == true): ## bullet knockback
		velocity += Vector2(-15,-5)
		smartguy == false
	elif(smartguy == true) && (face_dir == false):
		velocity += Vector2(15,-5)
		smartguy == false
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)


	if $Chain.hooked:
		update_hooked($Chain.hooked)
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		chain_velocity = to_local($Chain.tip).normalized() * CHAIN_PULL
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
	
####signals n shit	
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

func _on_facing_direction_changed(facing_right):
	face_dir = facing_right 

#var no_g = false
#func _on_grappled_stop_grapple(is_stop_g):
#	print_debug(no_g)
#	no_g = is_stop_g # Replace with function body.
