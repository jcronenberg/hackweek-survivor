class_name LootTable
extends Node

@export var weapons: Array[Weapon]
## Note that these need to be set as 'local_to_scene',
## otherwise their state will persist across game restarts.
@export var upgrades: Array[UpgradeItem]


func get_possible_upgrades(amount: int) -> Array:
	var available_items: Array = []
	available_items.append_array(weapons.duplicate())
	available_items.append_array(upgrades.duplicate())
	var ret: Array = []
	for i in amount:
		var pick = null
		while not pick or ret.has(pick):
			if available_items.size() <= 0:
				return ret
			pick = available_items.pick_random()
			if (pick is Weapon and not pick.get_next_upgrade()) or \
				(pick is UpgradeItem and pick.level == pick.max_level):
				available_items.erase(pick)
				pick = null

		ret.append(pick)
		available_items.erase(pick)

	return ret


func calculate_max_level() -> int:
	var ret: int = 0
	for weapon in weapons:
		ret += weapon.upgrades.size()

	for upgrade in upgrades:
		ret += upgrade.max_level

	return ret
