class_name WeaponUpgrade
extends Resource

## Supports bbcode
@export var description: String
## Inverse, so positive makes weapon fire faster while negative makes weapon fire slower
@export var mod_fire_rate: float = 0.0
@export var mod_damage: int = 0
@export var mod_area_multiplier: float = 0.0
@export var mod_projectiles: int = 0
@export var mod_projectile_speed: float = 0.0
@export var mod_spread: float = 0
@export var mod_push_power: int = 0
