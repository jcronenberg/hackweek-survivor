class_name WeaponRam
extends Weapon

const RAM_STICK = preload("uid://4ldc5brsy4ed")

func fire() -> void:
	var target: Enemy = find_nearest_enemy()
	if not target:
		return

	var projectile: RamStick = RAM_STICK.instantiate()
	projectile.direction = global_position.direction_to(target.global_position).normalized()
	projectile.global_position = global_position
	add_child(projectile)
