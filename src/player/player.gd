class_name Player
extends CharacterBody2D

const DAMAGE_TICK_TIME = 0.3

@export var speed: int = 400
@export var max_health: int = 100
@export var health: int = 100
@export var level_requirement: int = 20
@export var level_scaling: float = 1.2
@export var xp: int = 0:
	set(value):
		xp = value
		Global.get_ui().set_xp_amount(value)
		if value >= next_level and \
			weapon.level < weapon.max_level:
			level_requirement = int(level_requirement * level_scaling)
			next_level += level_requirement
			Global.get_ui().show_upgrade()

@onready var player_sprite: Sprite2D = $PlayerSprite

var collided_enemies: Array[Enemy] = []
var damage_delta_time: float = 0.0
var damage_tween: Tween
var weapon: Weapon = null
var next_level: int = 20


func _ready() -> void:
	weapon = WeaponRam.new()
	add_child(weapon)


func _move() -> void:
	var direction = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		player_sprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		player_sprite.flip_h = true
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	velocity = direction.normalized() * speed
	move_and_slide()


func _physics_process(delta: float) -> void:
	_move()
	_calculate_damage(delta)


func _calculate_damage(delta: float) -> void:
	if collided_enemies.size() > 0:
		damage_delta_time -= delta
		if damage_delta_time <= 0:
			for enemy in collided_enemies:
				health -= enemy.damage
				health = clamp(health, 0, max_health)

			_update_health_bar()
			_show_damage()

			if health <= 0:
				Global.game_over.emit()

			damage_delta_time = DAMAGE_TICK_TIME
	else:
		damage_delta_time = 0.0


func _show_damage() -> void:
	if damage_tween:
		damage_tween.kill()

	damage_tween = create_tween()
	damage_tween.tween_property(self, "modulate", Color.RED, 0.05)
	damage_tween.tween_property(self, "modulate", Color.WHITE, 0.05).set_delay(0.05)


func _update_health_bar() -> void:
	%HealthBar.value = health
	%HealthBar.visible = health != max_health


func _on_damage_area_body_entered(body: Node2D) -> void:
	if not body is Enemy:
		return
	if not collided_enemies.has(body):
		collided_enemies.append(body)


func _on_damage_area_body_exited(body: Node2D) -> void:
	if not body is Enemy:
		return
	collided_enemies.erase(body)


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area is Pickup:
		if area is XpPickup:
			xp += area.xp_amount
		area.pick_up(global_position)
