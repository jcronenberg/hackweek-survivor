class_name RamStick
extends Area2D

@export var base_damage: int = 10
@export var speed: float = 800
@export var direction: Vector2:
	set(value):
		direction = value
		look_at(direction)
@export var push_power: int = 50


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	# Delay queue_free a bit to allow hitting enemies a bit off screen
	get_tree().create_timer(1.0).timeout.connect(queue_free)


func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.get_damage_dealt(base_damage)
		if body.weight < push_power:
			body.global_position += direction * (push_power - body.weight)
