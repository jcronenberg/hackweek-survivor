class_name HardDrive
extends Area2D

## How much degrees it spins over a second
@export var spin_speed: float
## How long the cooldown to hit the same enemy is
@export var hit_time: float
var duration: float
var damage: int
var speed: float
var direction: Vector2:
	set(value):
		direction = value
		look_at(direction)

var _spinning: bool = false
var _audio_fading_out = false
var _duration_delta_time: float = 0.0
var _hit_enemies: Dictionary[Enemy, float] = {}


func _physics_process(delta: float) -> void:
	if _spinning:
		rotate(deg_to_rad(spin_speed * delta))
		_duration_delta_time += delta
		if _duration_delta_time >= duration - 0.2 and not _audio_fading_out:
			get_tree().create_tween().tween_property(%Audio, "volume_db", %Audio.volume_db - 40, 0.2)
			_audio_fading_out = true
		if _duration_delta_time >= duration:
			queue_free()
	else:
		global_position += direction * speed * delta

	for enemy in _hit_enemies:
		_hit_enemies[enemy] += delta
		if _hit_enemies[enemy] >= hit_time:
			enemy.get_damage_dealt(damage)


func _on_body_entered(body: Node2D) -> void:
	if not body is Enemy:
		return

	if not _spinning:
		_spinning = true
		%Audio.play()
	_hit_enemies[body as Enemy] = 0.0
	body.get_damage_dealt(damage)


func _on_body_exited(body: Node2D) -> void:
	if not body is Enemy:
		return

	_hit_enemies.erase(body as Enemy)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if not _spinning:
		queue_free()
