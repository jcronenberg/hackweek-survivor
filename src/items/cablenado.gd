class_name Cablenado
extends Area2D

const DIRECTION_CHANGE_PROBABILITY = 60

var duration: float
var speed: float
var damage: int
var direction: Vector2

var _duration_delta_time: float = 0.0


func _physics_process(delta: float) -> void:
	_duration_delta_time += delta
	if _duration_delta_time >= duration:
		queue_free()

	if randi() % DIRECTION_CHANGE_PROBABILITY == 0:
		_change_direction()

	global_position += direction * speed * delta


func _change_direction() -> void:
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.get_damage_dealt(damage)
