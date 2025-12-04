extends PanelContainer

const ITEM = preload("uid://dqe8r8csc8jyw")

signal item_selected


func _ready() -> void:
	add_upgrade()


func add_upgrade() -> void:
	var item: Item = ITEM.instantiate()
	item.pressed.connect(_apply_upgrade)
	%ItemContainer.add_child(item)
	item.grab_focus()

func _apply_upgrade() -> void:
	Global.get_player().weapon.level += 1
	item_selected.emit()
