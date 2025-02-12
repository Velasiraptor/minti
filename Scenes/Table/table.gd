extends Node2D

var items_on_table := ["", ""]

var last_item = ""

@onready var item_left = %Item_left
@onready var item_right = %Item_right

var sprite_beer = preload("res://Sprites/Items/Beer.png")
var sprite_energy = preload("res://Sprites/Items/Energy.png")
var sprite_meat = preload("res://Sprites/Items/Meat.png")
var sprite_luck = preload("res://Sprites/Items/Horseshoe.png")
var sprite_protection = preload("res://Sprites/Items/Rune.png")
var sprite_fire = preload("res://Sprites/Items/Scroll.png")
var sprite_pillow = preload("res://Sprites/Items/Pillow.png")


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
	
	print(items_on_table)


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
