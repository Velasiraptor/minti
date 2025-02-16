extends Control

@onready var back = %Back
@onready var exit = %Exit
@onready var audio_ui = %Audio_UI

var active = 0

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and active == 1:
		if visible:
			visible = false
		else:
			visible = true
 
func active_exit_menu_true(): #Активируется на старте игры
	active = 1 

func _on_back_pressed():
	visible = false

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_back_mouse_entered():
	audio_ui.play()


func _on_exit_mouse_entered():
	audio_ui.play()
