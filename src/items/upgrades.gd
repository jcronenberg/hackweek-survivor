class_name Upgrades
extends Resource

@export var upgrades: Array[UpgradeItem] = []
## Inverse, so positive makes weapon fire faster while negative makes weapon fire slower
@export var mod_fire_rate: float = 0.0
@export var mod_damage: int = 0
@export var mod_area_multiplier: float = 0.0
@export var mod_projectiles: int = 0


func update_modifiers() -> void:
	for upgrade in upgrades:
		mod_fire_rate += upgrade.mod_fire_rate * upgrade.level
		mod_damage += upgrade.mod_damage * upgrade.level
		mod_area_multiplier += upgrade.mod_area_multiplier * upgrade.level
		mod_projectiles += upgrade.mod_projectiles * upgrade.level
