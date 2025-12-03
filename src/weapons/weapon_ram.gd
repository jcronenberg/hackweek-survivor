class_name WeaponRam
extends Weapon

const RAM_STICK = preload("uid://4ldc5brsy4ed")
var fire_amount: int = 3
var spread: float = deg_to_rad(15)

func fire() -> void:
	var target: Enemy = find_nearest_enemy()
	if not target:
		return

	var direction: Vector2 = global_position.direction_to(target.global_position).normalized()

	if fire_amount == 1:
		_shoot_ram_at(direction)
		return

	var cur_angle: float = -spread * ((fire_amount - 1) / 2.0)

	for _i in fire_amount:
		_shoot_ram_at(direction.rotated(cur_angle))
		cur_angle += spread


func _shoot_ram_at(direction: Vector2) -> void:
	var projectile: RamStick = RAM_STICK.instantiate()
	projectile.direction = direction
	projectile.global_position = global_position
	add_child(projectile)
