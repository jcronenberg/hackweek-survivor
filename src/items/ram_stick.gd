class_name RamStick
extends Area2D

var damage: int
var speed: float
var push_power: int
var direction: Vector2:
	set(value):
		direction = value
		look_at(direction)


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# get_tree().create_timer(1.0).timeout.connect(queue_free)
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.get_damage_dealt(damage)
		if body.weight < push_power:
			body.global_position += direction * (push_power - body.weight)
