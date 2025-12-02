class_name Weapon
extends Node2D

@export var fire_rate: float = 1

var fire_rate_delta_time: float = 0.0


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
