class_name Enemy
extends Area2D

@export var speed: int = 200
@export var damage: int = 3


func _physics_process(delta: float) -> void:
	move_to_player(delta)


func move_to_player(delta: float) -> void:
	var player_pos: Vector2 = Global.get_player().position
	var player_distance: float = position.distance_to(player_pos)
	if player_distance <= 2:
		return
	var velocity: Vector2 = position.direction_to(player_pos).normalized() * speed * delta

	position += velocity
