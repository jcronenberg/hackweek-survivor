class_name Enemy
extends CharacterBody2D

@export var speed: int = 200
@export var damage: int = 3
@export var health: int = 20


func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

	add_to_group("enemies")


func _physics_process(delta: float) -> void:
	move_to_player(delta)


func move_to_player(_delta: float) -> void:
	var player_pos: Vector2 = Global.get_player().global_position
	velocity = position.direction_to(player_pos).normalized() * speed

	if velocity.x > 0: # right
		rotation_degrees = 0
		scale.y = 1
	else: # left
		rotation_degrees = 180
		scale.y = -1

	move_and_slide()


func get_damage_dealt(amount: int) -> void:
	health -= amount
	if health == 0:
		queue_free()
