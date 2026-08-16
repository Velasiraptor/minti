extends Node2D

var items_on_table := ["", ""]

var last_item = ""

@onready var item_left = %Item_left
@onready var item_right = %Item_right
@onready var choice_button = %Choice_button

@onready var audio_moo = %Audio_moo



var sprite_beer = preload("res://Sprites/Items/Beer.png")
var sprite_energy = preload("res://Sprites/Items/Energy.png")
var sprite_meat = preload("res://Sprites/Items/Meat.png")
var sprite_luck = preload("res://Sprites/Items/Horseshoe.png")
var sprite_protection = preload("res://Sprites/Items/Rune.png")
var sprite_fire = preload("res://Sprites/Items/Scroll.png")
var sprite_pillow = preload("res://Sprites/Items/Pillow.png")

var shop_active := false

func _ready():
	off_button_shop()

func _process(delta):
	visible_button()


func item_plus(name_item):
	if items_on_table[0] == "" and items_on_table[1] == "":
		items_on_table[0] = name_item
	elif items_on_table[0] == "" and items_on_table[1] != "":
		items_on_table[0] = name_item
	elif items_on_table[0] != "" and items_on_table[1] == "":
		items_on_table[1] = name_item
		last_item = name_item
	elif items_on_table[0] != "" and items_on_table[1] != "":
		for i in get_parent().get_node("Items").get_children():
			if i.name_item == last_item:
				i.item_off()
		items_on_table[1] = name_item
		last_item = name_item
	else:
		pass
	item_sprite(name_item)
	
	print(items_on_table)

func item_minus(name_item):
	if name_item == items_on_table[0]:
		item_left.texture = null
		items_on_table[0] = ""
	elif name_item == items_on_table[1]:
		item_right.texture = null 
		items_on_table[1] = ""
	

func item_sprite(name_item):
	if name_item == "beer": #Эль
		if name_item == items_on_table[0]:
			item_left.texture = sprite_beer
		elif name_item == items_on_table[1]:
			item_right.texture = sprite_beer 
	
	if name_item == "energy": #Энергетик
		if name_item == items_on_table[0]:
			item_left.texture = sprite_energy
		elif name_item == items_on_table[1]:
			item_right.texture = sprite_energy 
	
	if name_item == "meat": #Мясо
		if name_item == items_on_table[0]:
			item_left.texture = sprite_meat
		elif name_item == items_on_table[1]:
			item_right.texture = sprite_meat 
	
	if name_item == "luck": #подкова
		if name_item == items_on_table[0]:
			item_left.texture = sprite_luck
		elif name_item == items_on_table[1]:
			item_right.texture = sprite_luck 
	
	
	if name_item == "protection": #руна защиты
		if name_item == items_on_table[0]:
			item_left.texture = sprite_protection
		elif name_item == items_on_table[1]:
			item_right.texture = sprite_protection
	
	if name_item == "fire": #Свиток огня
		if name_item == items_on_table[0]:
			item_left.texture = sprite_fire
		elif name_item == items_on_table[1]:
			item_right.texture = sprite_fire
	
	if name_item == "pillow": #Подушка
		if name_item == items_on_table[0]:
			item_left.texture = sprite_pillow
		elif name_item == items_on_table[1]:
			item_right.texture = sprite_pillow


func visible_button():
	if items_on_table[0] != "" or items_on_table[1] != "":
		choice_button.visible = true
	else:
		choice_button.visible = false

func on_button_shop():
	choice_button.disabled = false
	choice_button.modulate = "ffffff"
	shop_active = true
func off_button_shop():
	choice_button.disabled = true
	choice_button.modulate = "ffffff41"
	shop_active = false

func _on_choice_button_pressed(): #ПРОДАЖА ПРЕДМЕТОВ
	if shop_active:
		get_tree().call_group("Dialogue", "choice_item")
		if items_on_table[0] != "":
			item_minus(items_on_table[0])
		if items_on_table[1] != "":
			item_minus(items_on_table[1])
		get_tree().call_group("Item", "item_off")
		off_button_shop() 

func choice_item(item_1, item_2, skeleton, thief):
	if (item_1 in items_on_table) and (item_2 in items_on_table) or skeleton:
		get_tree().call_group("Dialogue", "good_finish")
		off_button_shop()
		if (item_1 == "" or item_2 == "") or skeleton:
			get_tree().call_group("Game", "plus_gold")
		else:
			get_tree().call_group("Game", "plus_gold")
			await get_tree().create_timer(1.5).timeout
			get_tree().call_group("Game", "plus_gold")
	else:
		get_tree().call_group("Dialogue", "bad_finish")
		off_button_shop()
		await get_tree().create_timer(1.5).timeout
		audio_moo.play()
		await get_tree().create_timer(0.5).timeout
		get_tree().call_group("Game", "minus_hp")
	
	if thief:
		get_tree().call_group("Game", "map_visible_off")
		
