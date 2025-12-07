extends PanelContainer

const ITEM = preload("uid://dqe8r8csc8jyw")

signal item_selected


func _ready() -> void:
	var upgrades: Array = Global.loot_table.get_possible_upgrades(3)
	for upgrade in upgrades:
		add_upgrade(upgrade)

	item_selected.connect(_fade_time)


func add_upgrade(upgrade) -> void:
	var item: UpgradeItemEntry = ITEM.instantiate()
	item.init(upgrade)
	item.pressed.connect(item_selected.emit)
	%ItemContainer.add_child(item)
	item.grab_focus()


## Slows down time and fades it back slowly.
## Otherwise it can be hard for players to react after
## an upgrade was chosen.
func _fade_time() -> void:
	Engine.time_scale = 0.2
	get_tree().create_tween().tween_property(Engine, "time_scale", 1.0, 0.25)
