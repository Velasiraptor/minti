extends Sprite2D

@export var item_data: ItemData  ## тэг итема
@export var texture_normal: Texture ## спрайт с обводкой
@export var texture_hover: Texture ## спрайт с обводкой
@export var audio_open: AudioStream
@export var audio_close: AudioStream
@export var short_arm := true ## активная если предмет для короткой руки

@onready var audio_open_bestiary: AudioStreamPlayer2D = %Audio_open_bestiary
@onready var audio_close_bestiary: AudioStreamPlayer2D = %Audio_close_bestiary

@onready var description_window: Sprite2D = %Description_window
@onready var decr_label: Label = %decr_Label

var item_active := false
var mouse_in_item := false
var item_scale: Vector2
var item_rotation: float
var item_name: String
var item_description: String


func _ready():
	modulate = "ffffff"
	item_active = false
	texture = texture_normal
	audio_open_bestiary.stream = audio_open
	audio_close_bestiary.stream = audio_close
	item_scale = scale
	item_rotation = rotation
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
		if mouse_in_item and not item_active:
			arm_minti()
			item_on(ActiveTable.active_page)


func _on_area_player_mouse_entered(): # Курсор на предмете
	if not item_active:
		texture = texture_hover
		mouse_in_item = true
		description_window.visible = true


func _on_area_player_mouse_exited(): # Курсор не на предмете
	texture = texture_normal
	mouse_in_item = false
	description_window.visible = false


func item_on(active_page): # Открытие бестиария
	modulate = "929292"
	animation_item_on()
	audio_open_bestiary.play()
	item_active = true
	texture = texture_normal
	mouse_in_item = false
	description_window.visible = false
	get_tree().call_group("Bestiary_window", "bestiary_window_open", active_page)


func item_off(): # Закрытие бестиария
	modulate = "ffffff"
	animation_item_on()
	audio_close_bestiary.play()
	item_active = false


func animation_item_on(): # анимация клика, когда на столе нет предмета
	var tween = get_tree().create_tween()
	tween.tween_property($".", "scale", Vector2(item_scale*1.1), 0.1)
	tween.tween_property($".", "scale", Vector2(item_scale), 0.1)


func arm_minti(): # анимация короткой/длинной руки минти
	if short_arm:
		get_tree().call_group("Minotaur", "grab_short")
	else:
		get_tree().call_group("Minotaur", "grab_long")
