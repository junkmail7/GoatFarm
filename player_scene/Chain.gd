extends Node2D

@onready var links = $Links	
#@onready var tip : Vector2 = $Tip
#@onready var sprite : Sprite2D = $hook
@onready var timer : Timer = $Timer

	# A slightly easier reference to the links
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip = Vector2(0,0)			# The global position the tip should be in
								# We use an extra var for this, because the chain is 
								# connected to the player and thus all .position
								# properties would get messed with when the player
								# moves.

const SPEED = 20	# The speed with which the chain moves

var flying = false	# Whether the chain is moving through the air
var hooked = false	# Whether the chain has connected to a wall

# shoot() shoots the chain in a given direction
func shoot(dir: Vector2) -> void:
	timer.start()
	direction = dir.normalized()
	flying = true	# Normalize the direction and save it					# Keep track of our current scan
	tip = self.global_position		# reset the tip position to the player's position

# release() the chain
func release() -> void:
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked	# Only visible if flying or attached to something	
	if not self.visible:
		return	# Not visible -> nothing to draw
	var tip_loc = to_local(tip)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	links.rotation = self.position.angle_to_point(tip_loc) + deg_to_rad(90)
	$Tip.rotation = self.position.angle_to_point(tip_loc) + deg_to_rad(90)
	#print(tip_loc)
	links.position = tip_loc 						# The links are moved to start at the tip
	links.region_rect.size.y = tip_loc.length()		# and get extended for the distance between (0,0) and the tip

# Every physics frame we update the tip position
func _physics_process(_delta: float) -> void:
	$Tip.global_position = tip
	#print(tip)	# The player might have moved and thus updated the position of the tip -> reset it
	if flying:
		# `if move_and_collide()` always moves, but returns true if we did collide
		if $Tip.move_and_collide(direction * SPEED):
			hooked = true	# Got something!
			flying = false	# Not flying anymore
	tip = $Tip.global_position	# set `tip` as starting position for next frame



func _on_timer_timeout():
	if(hooked == false):
		flying = false	# Not flying anymore	
		hooked = false









#old attempt

#extends Area2D
#
#@export var hook_speed = 700
#@onready var player = get_parent().get_parent().get_parent()
#@onready var grapple = get_parent()
#
#var dir_x = 1
#var dir_y = 0
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	print("hook is alive")
#	timer.start()
#	player.connect("facing_direction_changed", _on_player_facing_direction_changed)
#	grapple.connect("hook_pos", _on_hook_pos_get)
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var motion = (Vector2(dir_x, dir_y)).normalized() * hook_speed
#	set_position(get_position() + motion * delta)
#	rotation = -(Vector2(1, -1).angle())
#	#var collision = 
#	#move_and_collide( rotation * hook_speed)
#
#
#func _on_timer_timeout():
#	queue_free()
#
#func _on_hook_pos_get(pos : Vector2):
#	print_debug(pos)
#
#func _on_player_facing_direction_changed(facing_right : bool):
#	if(facing_right):
#		dir_x = 1
#	else:
#		dir_x = -1
#	player.disconnect("facing_direction_changed", _on_player_facing_direction_changed)
#	return dir_x
#
#func _on_body_entered(body):
#	for child in body.get_children():
#		if child is Damageable:
#			var damage = 4
#			child.hit(damage, Vector2.RIGHT)



