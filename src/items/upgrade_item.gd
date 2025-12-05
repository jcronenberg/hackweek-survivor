class_name UpgradeItem
extends Resource

signal leveled_up

@export var icon: CompressedTexture2D
@export var item_name: String
@export var flavor_text: String
@export var description: String
@export var mod_fire_rate: float = 0.0
@export var mod_damage: int = 0
@export var mod_area_multiplier: float = 0.0
@export var mod_projectiles: int = 0
@export var max_level: int = 1

var level: int = 0


func level_up() -> void:
	if level == 0: # Upgrade is being added
		Global.get_player().add_upgrade_item(self)

	level += 1
	leveled_up.emit()
