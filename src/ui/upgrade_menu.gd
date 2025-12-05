extends PanelContainer

const ITEM = preload("uid://dqe8r8csc8jyw")

signal item_selected


func _ready() -> void:
	add_upgrade()


func add_upgrade() -> void:
	var item: UpgradeItemEntry = ITEM.instantiate()

	# hardcoded for now
	item.init(Global.get_player().weapons[0])

	item.pressed.connect(item_selected.emit)
	%ItemContainer.add_child(item)
	item.grab_focus()
