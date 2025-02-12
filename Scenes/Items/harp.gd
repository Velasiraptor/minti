extends Area2D

@onready var music = %Music
@onready var harp_spr = %Harp_spr
@onready var harp_outline_spr = %HarpOutline_spr
@onready var animation_harp = %Animation_Harp



var mouse_in_item := false

func _ready():
	harp_spr.visible = true
	harp_outline_spr.visible = false
	music.volume_db = -20

func _process(delta):
	button_music()

func _on_mouse_entered():
	mouse_in_item = true
	harp_outline_spr.visible = true


func _on_mouse_exited():
	mouse_in_item = false
	harp_outline_spr.visible = false

func button_music():
	if Input.is_action_just_pressed("click") and mouse_in_item == true:
		if music.volume_db == -20:
			music.volume_db = -100
			animation_harp.stop()
		elif music.volume_db == -100:
			music.volume_db = -20
			animation_harp.play("play_music")
