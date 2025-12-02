class_name Enemy
extends CharacterBody2D

@export var speed: int = 200
@export var damage: int = 3


func _physics_process(delta: float) -> void:
	move_to_player(delta)


func move_to_player(_delta: float) -> void:
	var player_pos: Vector2 = Global.get_player().position
	var player_distance: float = position.distance_to(player_pos)
	if player_distance <= 2:
		return
	velocity = position.direction_to(player_pos).normalized() * speed

	if velocity.x > 0: # right
		rotation_degrees = 0
		scale.y = 1
	else: # left
		rotation_degrees = 180
		scale.y = -1

	move_and_slide()
