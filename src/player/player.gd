class_name Player
extends CharacterBody2D

@export var speed: int = 400
@export var max_health: int = 100
@export var health: int = 100
const damage_tick_time = 0.3

var collided_enemies: Array[Enemy] = []
var flashing_state_red: bool = false
var flashing_state_delta_time: float = 0.0
var damage_delta_time: float = 0.0
@onready var player_sprite: Sprite2D = $PlayerSprite


func _ready() -> void:
	add_child(WeaponRam.new())


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
	_show_damage(delta)
	_calculate_damage(delta)


func _calculate_damage(delta: float) -> void:
	if collided_enemies.size() > 0:
		damage_delta_time -= delta
		if damage_delta_time <= 0:
			for enemy in collided_enemies:
				health -= enemy.damage
				health = clamp(health, 0, max_health)

			_update_health_bar()

			if health <= 0:
				Global.game_over.emit()

			damage_delta_time = damage_tick_time
	else:
		damage_delta_time = 0.0


func _show_damage(delta: float) -> void:
	if collided_enemies.size() > 0:
		if flashing_state_delta_time >= damage_tick_time:
			flashing_state_red = not flashing_state_red
			flashing_state_delta_time = 0

		flashing_state_delta_time += delta
		modulate = Color(0.656, 0.0, 0.0, 1.0) if flashing_state_red else Color(1.0, 0.355, 0.288, 1.0)
	else:
		modulate = Color(1, 1, 1, 1)
		flashing_state_delta_time = 0.0
		flashing_state_red = false


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
