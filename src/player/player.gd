class_name Player
extends CharacterBody2D

const DAMAGE_TICK_TIME = 0.3

@export var speed: int
@export var max_health: int
@export var health: int
@export var level_requirement: int
@export var level_scaling: float
@export var weapons: Array[Weapon] = []
@export var upgrades: Upgrades = Upgrades.new()
@export var xp: int = 0:
	set(value):
		xp = value
		if level >= max_level:
			return
		Global.ui.set_xp_amount(value)
		if value >= next_level:
			level_requirement = int(level_requirement * level_scaling)
			next_level += level_requirement
			level += 1
			Global.ui.show_upgrade()

var collided_enemies: Array[Enemy] = []
var damage_delta_time: float = 0.0
var damage_tween: Tween
var level: int = 1
var max_level: int = 0
var next_level: int = 20:
	set(value):
		Global.ui.set_max_xp(value)
		next_level = value


func _ready() -> void:
	Global.loot_table.weapons[0].level_up()
	max_level = Global.loot_table.calculate_max_level()


func _physics_process(delta: float) -> void:
	_move()
	_calculate_damage(delta)


func add_weapon(weapon: Weapon) -> void:
	weapons.append(weapon)
	weapon.owner = null
	weapon.player_upgrades = upgrades
	weapon.reparent(self)
	weapon.global_position = global_position


func add_upgrade_item(upgrade: UpgradeItem) -> void:
	upgrades.upgrades.append(upgrade)
	upgrade.leveled_up.connect(upgrades.update_modifiers)


func _move() -> void:
	var direction = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		%PlayerSprite.flip_h = false
		%PlayerOutlineSprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		%PlayerSprite.flip_h = true
		%PlayerOutlineSprite.flip_h = true
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	velocity = direction.normalized() * speed
	move_and_slide()


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
