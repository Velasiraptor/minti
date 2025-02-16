extends Control

@onready var audio_ui = %Audio_UI


func _on_play_pressed(): #ИГРАТЬ
	get_tree().change_scene_to_file("res://game.tscn")


func _on_exit_pressed():#ВЫХОД
	get_tree().quit()




func _on_play_mouse_entered():
	audio_ui.play()


func _on_exit_mouse_entered():
	audio_ui.play()
