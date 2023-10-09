extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@export var starting_move_direction : Vector2 = Vector2.LEFT
@onready var character_state_machine : CharacterStateMachine = $CharacterStateMachine

@export var SPEED = 25.0
@export var hit_state : State
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction : Vector2 = starting_move_direction
	if direction && character_state_machine.check_if_can_move():
		velocity.x = direction.x * SPEED
	elif character_state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
