class_name WeaponRam
extends Weapon

const SOUND = preload("uid://cbtiibwrufqkq")
const RAM_STICK = preload("uid://4ldc5brsy4ed")

var spread: float = 15 # In degrees
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	max_level = 24
	audio_player.stream = SOUND
	audio_player.pitch_scale = 1.2
	add_child(audio_player)


func fire() -> void:
	var target: Enemy = find_nearest_enemy()
	if not target:
		return

	audio_player.play()

	var direction: Vector2 = global_position.direction_to(target.global_position).normalized()

	if level == 1:
		_shoot_ram_at(direction)
		return

	var cur_angle: float = -spread * ((level - 1) / 2.0)

	for _i in level:
		_shoot_ram_at(direction.rotated(deg_to_rad(cur_angle)))
		cur_angle += spread


func _shoot_ram_at(direction: Vector2) -> void:
	var projectile: RamStick = RAM_STICK.instantiate()
	projectile.direction = direction
	projectile.global_position = global_position
	add_child(projectile)
