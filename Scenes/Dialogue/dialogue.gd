extends AnimatedSprite2D

@export var text_1 = ""
@export var txt_1_arm_idle = true
@export var txt_1_arm_nice = false
@export var txt_1_arm_dis = false

@export var text_2 = ""
@export var txt_2_arm_idle = true
@export var txt_2_arm_nice = false
@export var txt_2_arm_dis = false

@export var text_3 = ""
@export var txt_3_arm_idle = true
@export var txt_3_arm_nice = false
@export var txt_3_arm_dis = false

@export var text_4 = ""
@export var txt_4_arm_idle = true
@export var txt_4_arm_nice = false
@export var txt_4_arm_dis = false

@export var text_5 = ""
@export var txt_5_arm_idle = true
@export var txt_5_arm_nice = false
@export var txt_5_arm_dis = false

@export var text_good = ""
@export var text_bad = ""

@export var item_1 = "" ## beer,  energy,  meat,  luck,  protection,  fire,  pillow
@export var item_2 = "" ## beer,  energy,  meat,  luck,  protection,  fire,  pillow
 
@export var skeleton := false ## Если это скелет, то true. Скелет принимает любые итемы
@export var thief := false ## Если это вор, и нам нужно чтобы он украл карту, то true.
@export var dwarf_pillow := false ## Если это гном, и нам нужно чтобы он поднялся выше, то true.

@onready var start_animation = %Start_animation
@onready var animation_text = %Animation_text
@onready var text_input = %text_input

#Звуки
@onready var audio_step = %Audio_step
@onready var audio_good = %Audio_good
@onready var audio_bad = %Audio_bad

@onready var timer_talk = %Timer_talk

@onready var audio_bell = %Audio_bell


var actual_text = ""
var active_character := false
var last_text = ""

func _ready():
	visible = false
	text_input.visible_ratio = 0


func last_text_on_shop():
	if text_2 == "":
		last_text = "txt1"
	elif text_3 == "":
		last_text = "txt2"
	elif text_4 == "":
		last_text = "txt3"
	elif text_5 == "":
		last_text = "txt4"
	else:
		last_text = "txt5"

func _process(delta):
	if active_character:
		next_text()
	

func active():
	active_character = true
func not_active():
	active_character = false


func ready_dialogue(): 
	actual_text = text_1
	get_tree().call_group("Table", "off_button_shop")
	last_text_on_shop()
	modulate = "ffffff00"
	visible = true
	play("idle")
	start_animation.play("start")
	audio_step.play() #звук шагов
	await get_tree().create_timer(2.0).timeout
	active()
	start_talk(actual_text)


func start_talk(actual_text):
	timer_talk.stop()
	text_input.text = actual_text
	text_input.visible = false
	animation_text.play("run_text")
	play("talk")
	get_tree().call_group("Minotaur", "left_arm", true, false, false, false)
	timer_talk.start()

func _on_timer_talk_timeout():
	play("idle")
	minotaur_left_arm_anim()
	await get_tree().create_timer(0.1).timeout
	active_button_shop()

func minotaur_left_arm_anim():
	if actual_text == text_1:
		if txt_1_arm_idle:
			get_tree().call_group("Minotaur", "left_arm", true, false, false)
		elif txt_1_arm_nice:
			get_tree().call_group("Minotaur", "left_arm", false, true, false)
		elif txt_1_arm_dis:
			get_tree().call_group("Minotaur", "left_arm", false, false, true)
	elif actual_text == text_2:
		if txt_2_arm_idle:
			get_tree().call_group("Minotaur", "left_arm", true, false, false)
		elif txt_2_arm_nice:
			get_tree().call_group("Minotaur", "left_arm", false, true, false)
		elif txt_2_arm_dis:
			get_tree().call_group("Minotaur", "left_arm", false, false, true)
	elif actual_text == text_3:
		if txt_3_arm_idle:
			get_tree().call_group("Minotaur", "left_arm", true, false, false)
		elif txt_3_arm_nice:
			get_tree().call_group("Minotaur", "left_arm", false, true, false)
		elif txt_3_arm_dis:
			get_tree().call_group("Minotaur", "left_arm", false, false, true)
	elif actual_text == text_4:
		if txt_4_arm_idle:
			get_tree().call_group("Minotaur", "left_arm", true, false, false)
		elif txt_4_arm_nice:
			get_tree().call_group("Minotaur", "left_arm", false, true, false)
		elif txt_4_arm_dis:
			get_tree().call_group("Minotaur", "left_arm", false, false, true)
	elif actual_text == text_5:
		if txt_5_arm_idle:
			get_tree().call_group("Minotaur", "left_arm", true, false, false)
		elif txt_5_arm_nice:
			get_tree().call_group("Minotaur", "left_arm", false, true, false)
		elif txt_5_arm_dis:
			get_tree().call_group("Minotaur", "left_arm", false, false, true)

func next_text():
	if active_character:
		if Input.is_action_just_pressed("ui_accept"):
			if text_input.visible_ratio != 1:
				animation_text.stop()
				text_input.visible_ratio = 1
				play("idle")
				
			else:
				if actual_text == text_1:
					if text_2 != "":
						actual_text = text_2
						start_talk(actual_text)
						play("talk")
						await get_tree().create_timer(2.0).timeout
						if actual_text == text_1:
							play("idle")
							if last_text == "txt2":
								get_tree().call_group("Table", "on_button_shop")
					else:
						play("idle")
						get_tree().call_group("Table", "on_button_shop")
				elif actual_text == text_2:
					if text_3 != "":
						actual_text = text_3
						start_talk(actual_text)
						play("talk")
						await get_tree().create_timer(2.0).timeout
						if actual_text == text_2:
							play("idle")
							if last_text == "txt3":
								get_tree().call_group("Table", "on_button_shop")
					else:
						play("idle")
						get_tree().call_group("Table", "on_button_shop")
				elif actual_text == text_3:
					if text_4 != "":
						actual_text = text_4
						start_talk(actual_text)
						play("talk")
						await get_tree().create_timer(2.0).timeout
						if actual_text == text_3:
							play("idle")
							if last_text == "txt4":
								get_tree().call_group("Table", "on_button_shop")
					else:
						play("idle")
						get_tree().call_group("Table", "on_button_shop")
				elif actual_text == text_4:
					if text_5 != "":
						actual_text = text_5
						start_talk(actual_text)
						play("talk")
						await get_tree().create_timer(2.0).timeout
						if actual_text == text_4:
							play("idle")
							if last_text == "txt5":
								get_tree().call_group("Table", "on_button_shop")
					else:
						play("idle")
						get_tree().call_group("Table", "on_button_shop")

func active_button_shop():
	if active_character:
		if last_text == "txt2" and text_input.visible_ratio == 1 and actual_text == text_2:
			get_tree().call_group("Table", "on_button_shop")
			audio_bell.play()
		elif last_text == "txt3" and text_input.visible_ratio == 1 and actual_text == text_3:
			get_tree().call_group("Table", "on_button_shop")
			audio_bell.play()
		elif last_text == "txt4" and text_input.visible_ratio == 1 and actual_text == text_4:
			get_tree().call_group("Table", "on_button_shop")
			audio_bell.play()
		elif last_text == "txt5" and text_input.visible_ratio == 1 and actual_text == text_5:
			get_tree().call_group("Table", "on_button_shop")
			audio_bell.play()


func choice_item():
	if active_character:
		get_tree().call_group("Table", "choice_item", item_1, item_2, skeleton, thief)


func good_finish():
	if active_character:
		if dwarf_pillow == true:
			#ВСЕ ДИАЛОГИ С ГНОМАМИ СТАЛИ ВЫШЕ
			get_tree().call_group("Game", "The_tall_dwarves")
		active_character = false
		start_talk(text_good)
		audio_good.play()
		get_tree().call_group("Table", "off_button_shop")
		await get_tree().create_timer(4.0).timeout
		start_animation.play_backwards("start")
		audio_step.play() #звук шагов
		get_tree().call_group("Game", "End")
		get_tree().call_group("Game", "next_dialogue")
		
func bad_finish():
	if active_character:
		active_character = false
		
		start_talk(text_bad)
		audio_bad.play()
		get_tree().call_group("Table", "off_button_shop")
		await get_tree().create_timer(4.0).timeout
		start_animation.play_backwards("start")
		audio_step.play() #звук шагов
		get_tree().call_group("Game", "End")
		get_tree().call_group("Game", "next_dialogue")
		
