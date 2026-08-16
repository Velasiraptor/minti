extends Sprite2D

@export var name_item := "item" ## название итема (тэг)
@export var texture_normal: Texture ## спрайт с обводкой
@export var texture_hover: Texture ## спрайт с обводкой
@export var audio_click: AudioStream
@export var short_arm := true ## активная если предмет для короткой руки

@onready var audio_item = %Audio_item

var item_active := false
var mouse_in_item := false
var item_scale: Vector2
var item_rotation: float


func _ready():
	texture = texture_normal
	audio_item.stream = audio_click
	item_scale = scale
	item_rotation = rotation
	item_active = false
	mouse_in_item = false


func _input(event: InputEvent) -> void: # нажатие на предмет
	if mouse_in_item and event.is_action_pressed("click") and not item_active and ActiveTable.active_table == false:
		item_on()
		arm_minti()
	elif mouse_in_item and event.is_action_pressed("click") and item_active and ActiveTable.active_table == true:
		item_off()
	elif mouse_in_item and event.is_action_pressed("click"):
		animation_item_off()


func _on_area_player_mouse_entered(): # Курсор на предмете
	texture = texture_hover
	mouse_in_item = true


func _on_area_player_mouse_exited(): # Курсор не на предмете
	texture = texture_normal
	mouse_in_item = false


func item_on(): #Использование итема на стол
	item_active = true
	modulate = "929292"
	animation_item_on()
	audio_item.play()
	get_tree().call_group("Table", "get_item", texture_normal, name_item)


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
