extends Control

@onready var audio_ui = %Audio_UI

func _ready():
	visible = true


func _on_start_game_pressed():
	visible = false
	get_tree().call_group("Game", "start_game")


func _on_start_game_mouse_entered():
	audio_ui.play()
