extends Area2D
@export var bullet_speed = 1000
@onready var parent = get_parent().get_parent().get_parent()
@onready var timer : Timer = $Timer

var dir_x = 1
var dir_y = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("bullet is alive")
	timer.start()
	parent.connect("facing_direction_changed", _on_player_facing_direction_changed)
	#print(parent.connect("facing_direction_changed", _on_player_facing_direction_changed))

# Called every frame. 'delta' is the elapsed time since the previous frame.
var motion = 0
func _process(delta):
	if (is_parried == false):
		motion = (Vector2(dir_x, dir_y)).normalized() * bullet_speed
		set_position(get_position() + motion * delta)
	else:
		motion = parried_dir * bullet_speed
		set_position(get_position() + motion * delta)


func _on_timer_timeout():
	queue_free()


func _on_player_facing_direction_changed(facing_right : bool):
	if(facing_right):
		dir_x = 1
	else:
		dir_x = -1
	parent.disconnect("facing_direction_changed", _on_player_facing_direction_changed)
	return dir_x
	
func _on_body_entered(body):
	for child in body.get_children():
		print(child)
		if child is Damageable_Enemy:
			var direction_to_damageable = (body.global_position - get_parent().get_parent().get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			var damage = 6
			if(direction_sign > 0):
				child.hit(damage, Vector2.RIGHT)
			elif(direction_sign < 0):
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.UP)
				
var is_parried = false
var parried_dir = Vector2(0,0)

func _on_parryable_on_parried(node, knockback_direction):
	is_parried = true
	parried_dir = knockback_direction


