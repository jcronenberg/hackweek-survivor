class_name Game
extends Node2D

const ENEMY_GODOT = preload("uid://dcai8d26135ma")
const ENEMY_BOSS_SEGFAULT = preload("uid://cnfw626eys7b")

@export var spawn_rate: float = 2.0
var spawn_delta_time: float = 1.0
var spawn_amount: int = 2
var increase_spawn_amount: float = 50.0
var increase_spawn_amount_time: float = 0.0

@onready var spawn_rect: Rect2 = %SpawnAreaShape.shape.get_rect()

var _spawn_points: Array[Vector2] = []


func _ready() -> void:
	Global.kill_count = 0


func _physics_process(delta: float) -> void:
	spawn_delta_time += delta
	if spawn_delta_time >= spawn_rate:
		for _i in spawn_amount:
			_generate_spawn_point()

		spawn_delta_time = 0.0
		_spawn_enemies()

	increase_spawn_amount_time += delta
	if increase_spawn_amount_time >= increase_spawn_amount:
		spawn_amount += 1
		increase_spawn_amount_time = 0.0


func add_pickup(pickup: Pickup) -> void:
	%Pickups.add_child(pickup)


func get_player() -> Player:
	return %Player


func get_ui() -> Ui:
	return %Ui


func get_projectile_node() -> Node2D:
	return %Projectiles


## This spawning algorithm basically picks a random point a line which is the
## length of a unwrapped perimeter of a rectangle (which is a rectangle that is
## a bit larger than the viewport so enemies spawn outside of view). Then it
## converts said perimeter point to the point it would would be in 2d space. And
## finally this is mapped to the players position. In the end enemies should
## spawn out of view, but close to the player with equal distribution on all
## sides.
func _generate_spawn_point() -> void:
	var rect: Vector2 = get_viewport_rect().size * 1.4
	var pos: Vector2
	while not pos or not spawn_rect.has_point(pos) or _point_is_near_other_spawn(pos):
		var rand: int = randi_range(0, 2 * int(rect.x) + 2 * int(rect.y))
		if rand <= rect.x:
			pos = Vector2(rand, 0)
		elif rand <= rect.x + rect.y:
			pos = Vector2(rect.x, rand - rect.x)
		elif rand <= 2 * rect.x + rect.y:
			pos = Vector2(rand - rect.x - rect.y, rect.y)
		else:
			pos = Vector2(0, rand - (2 * rect.x + rect.y))

		pos -= rect / 2
		pos += %Player.position

	_spawn_points.append(pos)


func _point_is_near_other_spawn(point: Vector2) -> bool:
	for pos in _spawn_points:
		if point.distance_to(pos) <= 50:
			return true
	return false



func _spawn_enemies() -> void:
	for pos in _spawn_points:
		var enemy: Enemy
		if randi() % 20 == 19:
			enemy = ENEMY_BOSS_SEGFAULT.instantiate()
		else:
			enemy = ENEMY_GODOT.instantiate()

		enemy.position = pos
		enemy.spawn_pickup.connect(add_pickup)
		%Enemies.add_child(enemy)

	_spawn_points = []
