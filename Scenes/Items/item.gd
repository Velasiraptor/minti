extends Sprite2D

@export var item_data: ItemData  ## тэг итема
@export var texture_normal: Texture ## спрайт с обводкой
@export var texture_hover: Texture ## спрайт с обводкой
@export var audio_click: AudioStream
@export var short_arm := true ## активная если предмет для короткой руки

@onready var audio_item = %Audio_item
@onready var description_window: Sprite2D = %Description_window
@onready var decr_label: Label = %decr_Label


var item_active := false
var mouse_in_item := false
var item_scale: Vector2
var item_rotation: float
var item_name: String
var item_description: String


func _ready():
	texture = texture_normal
	audio_item.stream = audio_click
	item_scale = scale
	item_rotation = rotation
	item_active = false
	mouse_in_item = false
	description_window.visible = false
	if item_data:
		if ConfigSettings.language == "RU":
			item_name = item_data.name_ru
			item_description = item_data.description_ru
		if ConfigSettings.language == "EN":
			item_name = item_data.name_en
			item_description = item_data.description_en
	decr_label.text = item_name


func _input(event: InputEvent) -> void: # нажатие на предмет
	if event.is_action_pressed("click"):
		if mouse_in_item:
			if not item_active and ActiveTable.active_table == false:
				item_on()
				arm_minti()
			elif item_active and ActiveTable.active_table == true:
				item_off()
			else:
				animation_item_off()
	elif event.is_action_pressed("PCM_click"):
		if mouse_in_item:
			open_bestiary()


func _on_area_player_mouse_entered(): # Курсор на предмете
	texture = texture_hover
	mouse_in_item = true
	description_window.visible = true


func _on_area_player_mouse_exited(): # Курсор не на предмете
	texture = texture_normal
	mouse_in_item = false
	description_window.visible = false


func item_on(): #Использование итема на стол
	item_active = true
	modulate = "929292"
	animation_item_on()
	audio_item.play()
	get_tree().call_group("Table", "get_item", texture_normal, item_name)


func item_off(): #Возвращение итема обратно
	item_active = false
	modulate = "ffffff"
	animation_item_on()
	audio_item.play()
	get_tree().call_group("Table", "delete_item")


func animation_item_on(): # анимация клика, когда на столе нет предмета
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(item_scale*1.1), 0.1)
	tween.tween_property($".", "scale", Vector2(item_scale), 0.1)


func animation_item_off(): # анимация клика, когда на столе есть предмет
	var tween = get_tree().create_tween()
	tween.tween_property($".", "rotation", item_rotation - 0.5, 0.1)
	tween.tween_property($".", "rotation", item_rotation + 0.5, 0.1)
	tween.tween_property($".", "rotation", item_rotation, 0.1)


func arm_minti(): # анимация короткой/длинной руки минти
	if short_arm:
		get_tree().call_group("Minotaur", "grab_short")
	else:
		get_tree().call_group("Minotaur", "grab_long")


func open_bestiary(): # Открытие бестиария
	print(item_data.id)
