extends Node2D

@onready var animation_space = %Animation_space

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func visible_space():
	animation_space.play("new_animation")
