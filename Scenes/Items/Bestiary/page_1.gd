extends TextureRect

@export var item_data: ItemData  ## тэг итема

@onready var name_label: Label = %name_Label
@onready var decr_label: Label = %decr_Label


func _ready() -> void:
	if item_data:
		if ConfigSettings.language == "RU":
			name_label.text = item_data.name_ru
			decr_label.text = item_data.description_ru
		if ConfigSettings.language == "EN":
			name_label.text = item_data.name_en
			decr_label.text = item_data.description_en
