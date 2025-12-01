class_name Player
extends Area2D

@export var speed: int = 400
@export var max_health: int = 100
@export var health: int = 100

var collided_enemies: Array[Enemy] = []
var flashing_state_red: bool = false
var flashing_state_delta_time: float = 0.0
var damage_delta_time: float = 0.0


func _ready() -> void:
	Global.get_ui().update_player_health(health)


func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta


func _physics_process(delta: float) -> void:
	_show_damage(delta)
	_calculate_damage(delta)


func _on_area_entered(area: Area2D) -> void:
	if not area is Enemy:
		return
	if not collided_enemies.has(area):
		collided_enemies.append(area)


func _on_area_exited(area: Area2D) -> void:
	if not area is Enemy:
		return
	collided_enemies.erase(area)


func _calculate_damage(delta: float) -> void:
	if collided_enemies.size() > 0:
		damage_delta_time -= delta
		if damage_delta_time <= 0:
			for enemy in collided_enemies:
				health -= enemy.damage
				health = clamp(health, 0, max_health)

			Global.get_ui().update_player_health(health)

			if health <= 0:
				Global.game_over.emit()
			damage_delta_time = 0.2 # How often damage is applied
	else:
		damage_delta_time = 0.0


func _show_damage(delta: float) -> void:
	if collided_enemies.size() > 0:
		if flashing_state_delta_time >= 0.2:
			flashing_state_red = not flashing_state_red
			flashing_state_delta_time = 0

		flashing_state_delta_time += delta
		modulate = Color(0.656, 0.0, 0.0, 1.0) if flashing_state_red else Color(1.0, 0.355, 0.288, 1.0)
	else:
		modulate = Color(1, 1, 1, 1)
		flashing_state_delta_time = 0.0
		flashing_state_red = false
