class_name WeaponRam
extends Weapon

const SOUND = preload("uid://cbtiibwrufqkq")
const RAM_STICK = preload("uid://4ldc5brsy4ed")

var fire_amount: int = 3:
	set(value):
		if spread * value <= 360:
			fire_amount = value
			print(fire_amount)
var spread: float = 15 # In degrees
var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	audio_player.stream = SOUND
	add_child(audio_player)


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
		_shoot_ram_at(direction.rotated(deg_to_rad(cur_angle)))
		cur_angle += spread

	audio_player.play()


func _shoot_ram_at(direction: Vector2) -> void:
	var projectile: RamStick = RAM_STICK.instantiate()
	projectile.direction = direction
	projectile.global_position = global_position
	add_child(projectile)
