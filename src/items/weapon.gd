class_name Weapon
extends Node2D

@export var icon: CompressedTexture2D
@export var item_name: String
@export var flavor_text: String
@export var upgrades: Array[WeaponUpgrade] = []
@export var fire_rate: float = 1.0
@export var damage: int = 0
@export var area_multiplier: float = 1.0
@export var projectiles: int = 1
@export var projectile_speed: float = 0.0
## In degrees
@export var spread: float = 0
@export var push_power: int = 0

var fire_rate_delta_time: float = 0.0
var level: int = 0
var player_upgrades: Upgrades = null
var max_level: int:
	get():
		return upgrades.size() - 1


func _physics_process(delta: float) -> void:
	fire_rate_delta_time += delta
	if fire_rate_delta_time >= fire_rate:
		fire()
		fire_rate_delta_time = 0.0


func fire() -> void:
	pass


## Returns null if there are no enemies
func find_nearest_enemy() -> Enemy:
	var nearest: Enemy = null
	var nearest_distance: float = 0.0
	for enemy in get_tree().get_nodes_in_group("enemies"):
		var distance: float = global_position.distance_to(enemy.global_position)
		if distance < nearest_distance or not nearest:
			nearest_distance = distance
			nearest = enemy

	return nearest


func level_up() -> void:
	assert(level < max_level)
	level += 1

	var upgrade: WeaponUpgrade = upgrades[level]
	fire_rate -= upgrade.mod_fire_rate * fire_rate
	damage += upgrade.mod_damage
	area_multiplier += upgrade.mod_area_multiplier
	projectiles += upgrade.mod_projectiles
	projectile_speed += upgrade.mod_projectile_speed
	spread += upgrade.mod_spread * spread
	push_power += upgrade.mod_push_power


func get_fire_rate() -> float:
	if player_upgrades:
		return fire_rate - player_upgrades.mod_fire_rate
	return fire_rate


func get_damage() -> int:
	if player_upgrades:
		return damage + player_upgrades.mod_damage
	return damage


func get_area_multiplier() -> float:
	if player_upgrades:
		return area_multiplier + player_upgrades.mod_area_multiplier
	return area_multiplier


func get_projectiles() -> int:
	if player_upgrades:
		return projectiles + player_upgrades.mod_projectiles
	return projectiles


func get_next_upgrade() -> WeaponUpgrade:
	return upgrades[level + 1] if level < max_level else null


func _on_level_up() -> void:
	pass
