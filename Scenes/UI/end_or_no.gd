extends Control

@onready var audio_ui = %Audio_UI
@onready var back = %Back
@onready var end = %End

func _ready():
	visible = false

func _on_back_pressed():
	visible = false


func _on_back_mouse_entered():
	audio_ui.play()

func _on_end_pressed():
	get_tree().change_scene_to_file("res://Scenes/Ends/good_end.tscn")


func _on_end_mouse_entered():
	audio_ui.play()
