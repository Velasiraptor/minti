extends Node2D

@onready var texture_item: Sprite2D = %texture_item
@onready var choice_button: TextureButton = %Choice_button

var ind_item: String
var item_scale := Vector2()


func _ready() -> void:
	item_scale = scale
	delete_item()


# Добавление картинки итема на стол
func get_item(get_texture_item: Texture, get_name_item: String):
	if ActiveTable.active_table == false:
		ActiveTable.active_table = true
		texture_item.texture = get_texture_item
		ind_item = get_name_item
		choice_button.visible = true
		animation_item()


func delete_item(): # Удаление предмета с стола
	ActiveTable.active_table = false
	texture_item.texture = null
	ind_item = ""
	choice_button.visible = false


func animation_item(): # анимация клика
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(item_scale*1.1), 0.1)
	tween.tween_property($".", "scale", Vector2(item_scale), 0.1)
