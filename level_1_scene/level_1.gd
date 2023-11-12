extends Node2D

var character_scene1 : PackedScene = preload("res://player_scene/character_body_2d.tscn")
var character_scene2 : PackedScene = preload("res://character_2/character_2.tscn")
var enemy : PackedScene = preload("res://enemy_scene/enemy.tscn")
var character_2_enemy : PackedScene = preload("res://character_2_enemy/character_2_enemy.tscn")
var blood : PackedScene = preload("res://blood/blood.tscn")
var gib_part : PackedScene = preload("res://items/gib_part.tscn")

# Called when the node enters the scene tree for the first time.

signal char_to_add(char : CharacterBody2D)

var p1 = null
var p2 = null

# Called when the node enters the scene tree for the first time.
func _ready():		
	if Global.online == true:
		print(Global.online)
		var index = 0
		for i in MultiplayerManager.players:
			var currentPlayer = character_scene1.instantiate()
			currentPlayer.name = str(MultiplayerManager.players[i].id)
			add_child(currentPlayer)
			for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
				if spawn.name == str(index):
					currentPlayer.global_position = spawn.global_position
			index += 1
	else:
		if Global.p1_char == 1:
			instantiate_character(character_scene1)
		elif Global.p1_char == 2:
			instantiate_character(character_scene2)
		if Global.p2_char == 1:
			instantiate_character(enemy)
		elif Global.p2_char == 2:
			instantiate_character(character_2_enemy)

var object1 = null
var object2 = null

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed("click")):
		for i in range(10):
			var blood_instance = blood.instantiate()
			blood_instance.global_position = get_global_mouse_position()
			add_child(blood_instance)
			
	if char_arr.size() == 2:	
		object1 = char_arr[0]
		object2 = char_arr[1]
		if(object1.state_machine.current_state.name == "hurt"):
			#print(object1.state_machine.current_state.name)
			var blood_instance = blood.instantiate()
			blood_instance.global_position = object1.global_position
			add_child(blood_instance)
		if(object1.state_machine.current_state.name == "dead"):
			#print(object1.state_machine.current_state.name)
			var gibstuff = gib_part.instantiate()
			gibstuff.global_position = object1.global_position
			add_child(gibstuff)
		if(object2.character_state_machine.current_state.name == "hurt"):
			#print(object1.state_machine.current_state.name)
			var blood_instance = blood.instantiate()
			blood_instance.global_position = object2.global_position
			add_child(blood_instance)
		if(object2.character_state_machine.current_state.name == "dead"):
			#print(object1.state_machine.current_state.name)
			var gibstuff = gib_part.instantiate()
			gibstuff.global_position = object2.global_position
			add_child(gibstuff)
		

# Function to instantiate a character
func instantiate_character(character_scene : PackedScene) -> void:
	var character_instance = character_scene.instantiate()

	# Check if the instance is valid
	if character_instance != null:
		add_child(character_instance)
		emit_signal("char_to_add", character_instance)


var char_arr = []

func _on_char_to_add(char):
	char_arr.push_back(char)
