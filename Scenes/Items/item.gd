extends Sprite2D

@export var name_item := "item" ## название итема
@export var texture_area = preload("res://icon.svg") ## спрайт с обводкой

@export var text_description = "" ## текст описания итема
@export var short_arm := true ## активная если предмет для короткой руки

@onready var area_item = %Area_item
@onready var description = %Description
@onready var decr_label = %decr_Label



var item_active := false
var mouse_in_item := false


func _ready():
	area_item.visible = false
	description.visible = false
	decr_label.text = text_description
	area_item.texture = texture_area
	item_active = false
	mouse_in_item = false

func _process(delta):
	input_item(name_item)


func _on_area_player_mouse_entered():
	area_item.visible = true
	mouse_in_item = true
	description.visible = true

func _on_area_player_mouse_exited():
	area_item.visible = false
	mouse_in_item = false
	description.visible = false


func input_item(name_item):
	if mouse_in_item and Input.is_action_just_pressed("click") and not item_active:
		item_active = true
		modulate = "929292"
		get_tree().call_group("Table", "item_plus", name_item)
		if short_arm:
			get_tree().call_group("Minotaur", "grab_short")
		else:
			get_tree().call_group("Minotaur", "grab_long")
		print(name_item) #тестовое
	elif mouse_in_item and Input.is_action_just_pressed("click") and item_active:
		item_off()

func item_off(): #Возвращение итема обратно
	item_active = false
	modulate = "ffffff"
	get_tree().call_group("Table", "item_minus", name_item)
	print("not" + name_item) #тестовое
