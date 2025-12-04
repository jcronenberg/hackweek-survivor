extends Control

const START_MENU = preload("uid://cg0rfyt64xmi5")


func _ready() -> void:
	%MenuContainer.add_child(START_MENU.instantiate())


func _clear_menu_container() -> void:
	for child in %MenuContainer.get_children():
		child.queue_free()
