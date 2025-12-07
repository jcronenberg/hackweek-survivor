class_name WeaponHardDrive
extends Weapon

const HARD_DRIVE = preload("uid://b38c5iyg7awq")


func fire() -> void:
	for i in get_projectiles():
		var enemy: Enemy = get_random_enemy()
		if not enemy:
			return

		var hard_drive: HardDrive = HARD_DRIVE.instantiate()
		# hard_drive.modulate.a -= level * 0.04
		hard_drive.direction = global_position.direction_to(enemy.global_position).normalized()
		hard_drive.scale *= get_area_multiplier()
		hard_drive.damage = get_damage()
		hard_drive.duration = duration
		hard_drive.speed = projectile_speed
		hard_drive.global_position = global_position
		Global.projectile_node.add_child(hard_drive)
