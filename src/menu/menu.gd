extends Control

const START_MENU = preload("uid://cg0rfyt64xmi5")
const SETTINGS_MENU = preload("uid://cv2uajd0ywiqa")


func _ready() -> void:
	_add_start_menu()


func _clear_menu_container() -> void:
	for child in %MenuContainer.get_children():
		child.queue_free()


func _add_start_menu() -> void:
	var start_menu = START_MENU.instantiate()
	start_menu.connect("settings_requested", _add_settings_menu)
	_clear_menu_container()
	%MenuContainer.add_child(start_menu)


func _add_settings_menu() -> void:
	var settings_menu = SETTINGS_MENU.instantiate()
	settings_menu.connect("return_requested", _add_start_menu)
	_clear_menu_container()
	%MenuContainer.add_child(settings_menu)
