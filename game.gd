extends Node2D

@onready var dialogues = %Dialogues
@onready var actual_dialogues = 0     

@onready var map = %Map

@onready var gold = %Gold
@onready var animation_gold = %Animation_gold
@onready var audio_gold = %Audio_gold


@onready var dwarf_1 = %Dwarf_1
@onready var dwarf_2 = %Dwarf_2
@onready var dwarf_3 = %Dwarf_3
@onready var dwarf_4 = %Dwarf_4
@onready var dwarf_5 = %Dwarf_5

@onready var full_hp_1 = %FullHp_1
@onready var full_hp_2 = %FullHp_2
@onready var full_hp_3 = %FullHp_3
@onready var left_hp_1 = %Left_Hp_1
@onready var right_hp_1 = %Right_Hp_1
@onready var left_hp_2 = %Left_Hp_2
@onready var right_hp_2 = %Right_Hp_2
@onready var left_hp_3 = %Left_Hp_3
@onready var right_hp_3 = %Right_Hp_3

@onready var button_good = %Button_good

@onready var exit_window = %Exit_window
@onready var end_or_no = %end_or_no


var full_hp = 3

var gold_start = 0

var finish_game = false

var count_dialogue = 0

func start_game():
	exit_window.active_exit_menu_true()
	count_dialogue = dialogues.get_child_count()
	await get_tree().create_timer(8.0).timeout
	dialogues.get_child(actual_dialogues).ready_dialogue()
	actual_dialogues += 1

func next_dialogue(): 
	if finish_game == false:
		if actual_dialogues != count_dialogue - 1:
			await get_tree().create_timer(4.0).timeout
			dialogues.get_child(actual_dialogues).ready_dialogue()
			actual_dialogues += 1
		else:
			await get_tree().create_timer(4.0).timeout
			dialogues.get_child(actual_dialogues).ready_dialogue()
			finish_game = true


func map_visible_off():
	map.visible = false

func The_tall_dwarves(): #УВЕЛИЧЕНИЕ ГНОМОВ
	dwarf_1.position.y -= 130 # ЗАМЕНИТЬ НА КАЖДЫЙ ДИАЛОГ С ГНОМОМ
	dwarf_2.position.y -= 130
	dwarf_3.position.y -= 130
	dwarf_4.position.y -= 130
	dwarf_5.position.y -= 130

func plus_gold():
	animation_gold.stop()
	gold_start += 40
	gold.text = str(gold_start) + " / 1000"
	animation_gold.play("plus")
	audio_gold.play()
	if gold_start >= 1000:
		button_good.visible = true
		button_good.disabled = false

func minus_hp():
	if full_hp == 3:
		full_hp -= 1
		full_hp_3.visible = false
		right_hp_3.emitting = true
		left_hp_3.emitting = true
	elif full_hp == 2:
		full_hp -= 1
		full_hp_2.visible = false
		right_hp_2.emitting = true
		left_hp_2.emitting = true
	elif full_hp == 1:
		full_hp -= 1
		full_hp_1.visible = false
		right_hp_1.emitting = true
		left_hp_1.emitting = true
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://Scenes/Ends/bad_end.tscn")

func End():
	await get_tree().create_timer(3.0).timeout
	if finish_game == true:
		await get_tree().create_timer(1.0).timeout
		if gold_start < 1000:
			get_tree().change_scene_to_file("res://Scenes/Ends/bad_end.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Ends/good_end.tscn")


func _on_button_good_pressed():
	end_or_no.visible = true
