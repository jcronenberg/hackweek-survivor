class_name WeaponCablenado
extends Weapon

const CABLENADO = preload("uid://b0xxy8chekp8a")

func fire() -> void:
	var direction: Vector2 = [
		Vector2(1, 0),
		Vector2(1, 1),
		Vector2(0, 1),
		Vector2(-1, 0),
		Vector2(-1, -1),
		Vector2(0, -1)
		].pick_random().normalized()

	_shoot_cablenado_in_direction(direction)

	for i in get_projectiles() - 1:
		_shoot_cablenado_in_direction(direction.rotated(deg_to_rad((360.0 / get_projectiles()) * (i + 1))))


func _shoot_cablenado_in_direction(direction: Vector2) -> void:
	var cablenado: Cablenado = CABLENADO.instantiate()
	cablenado.direction = direction
	cablenado.duration = duration
	cablenado.speed = projectile_speed
	cablenado.damage = get_damage()
	cablenado.global_position = global_position
	cablenado.scale *= get_area_multiplier()
	Global.projectile_node.add_child(cablenado)
