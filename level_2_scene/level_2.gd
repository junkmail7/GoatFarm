extends Node2D

var character_scene1 : PackedScene = preload("res://player_scene/character_body_2d.tscn")
var character_scene2 : PackedScene = preload("res://character_2/character_2.tscn")
var enemy : PackedScene = preload("res://enemy_scene/enemy.tscn")
# Called when the node enters the scene tree for the first time.

signal char_to_add(char : CharacterBody2D)

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.p1_char == 1:
		instantiate_character(character_scene1)
	elif Global.p1_char == 2:
		instantiate_character(character_scene2)
	if Global.p2_char == 1:
		instantiate_character(enemy)
	elif Global.p2_char == 2:
		instantiate_character(enemy)

# Function to instantiate a character
func instantiate_character(character_scene : PackedScene) -> void:
	var character_instance = character_scene.instantiate()

	# Check if the instance is valid
	if character_instance != null:
		add_child(character_instance)
		emit_signal("char_to_add", character_instance)
	
