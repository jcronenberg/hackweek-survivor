extends PanelContainer

const ITEM = preload("uid://dqe8r8csc8jyw")

signal item_selected


func _ready() -> void:
	var upgrades: Array = Global.loot_table.get_possible_upgrades(3)
	for upgrade in upgrades:
		add_upgrade(upgrade)


func add_upgrade(upgrade) -> void:
	var item: UpgradeItemEntry = ITEM.instantiate()
	item.init(upgrade)
	item.pressed.connect(item_selected.emit)
	%ItemContainer.add_child(item)
	item.grab_focus()
