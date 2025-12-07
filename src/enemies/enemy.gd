class_name Enemy
extends CharacterBody2D

@export var speed: int
@export var damage: int
@export var health: int
@export var weight: int
@export var xp_amount: int

var scaling: float:
	set(value):
		health = int(health * value)

signal spawn_pickup(pickup: Pickup)

const XP_PICKUP = preload("uid://bp8nuesiu80is")

var _dead: bool = false


func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	y_sort_enabled = true

	add_to_group("enemies")


func _physics_process(delta: float) -> void:
	move_to_player(delta)


func move_to_player(_delta: float) -> void:
	var player_pos: Vector2 = Global.player.global_position
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
	if health <= 0:
		_die()
	else:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(self, "modulate:v", 1, 0.25).from(10)


func _die() -> void:
	if _dead:
		return

	_dead = true
	set_process(false)
	set_physics_process(false)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:v", 1, 0.1).from(10)
	tween.tween_property(self, "scale", Vector2(), 0.1)
	tween.tween_callback(_spawn_xp)
	tween.tween_callback(queue_free)
	Global.kill_count += 1


func _spawn_xp() -> void:
	var xp_pickup = XP_PICKUP.instantiate()
	xp_pickup.xp_amount = xp_amount
	xp_pickup.global_position = global_position
	spawn_pickup.emit(xp_pickup)
