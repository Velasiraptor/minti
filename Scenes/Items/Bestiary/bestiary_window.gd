extends CanvasLayer

@onready var pages: Control = %Pages


func _ready() -> void:
	visible = false


func open_page(ind_page):
	for i in pages.get_children():
		if i == pages.get_child(ind_page):
			i.visible = true
		else:
			i.visible = false



# active_page - Активная страница
func bestiary_window_open(active_page):
	visible = true
	open_page(active_page)


func _on_button_close_pressed() -> void: # Закрытие бестиария
	get_tree().call_group("Bestiary", "item_off")
	visible = false


func _on_button_next_right_pressed() -> void: # Перелистывание страницы вправо
	if ActiveTable.active_page == pages.get_child_count() - 1:
		ActiveTable.active_page = 0
	else:
		ActiveTable.active_page += 1
	open_page(ActiveTable.active_page)


func _on_button_next_left_pressed() -> void: # Перелистывание страницы влево
	if ActiveTable.active_page == 0:
		ActiveTable.active_page = pages.get_child_count() - 1
	else:
		ActiveTable.active_page -= 1
	open_page(ActiveTable.active_page)
