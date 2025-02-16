extends Node2D

var active = 0
@onready var animation_space = %Animation_space

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and active == 1:
		get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func active_space():
	active = 1
	animation_space.play("new_animation")
