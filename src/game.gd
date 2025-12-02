extends Node2D

const ENEMY_GODOT = preload("uid://dcai8d26135ma")
const ENEMY_BOSS_SEGFAULT = preload("uid://cnfw626eys7b")

@export var spawn_rate: float = 3.0
var spawn_delta_time: float = 0.0


func _physics_process(delta: float) -> void:
	spawn_delta_time += delta
	if spawn_delta_time >= spawn_rate:
		_spawn_enemy()
		spawn_delta_time = 0.0


## This spawning algorithm basically picks a random point a line which is the
## length of a unwrapped perimeter of a rectangle (which is a rectangle that is
## a bit larger than the viewport so enemies spawn outside of view). Then it
## converts said perimeter point to the point it would would be in 2d space. And
## finally this is mapped to the players position. In the end enemies should
## spawn out of view, but close to the player with equal distribution on all
## sides.
func _spawn_enemy() -> void:
	var rect: Vector2 = get_viewport_rect().size * 1.2
	var rand: int = randi_range(0, 2 * int(rect.x) + 2 * int(rect.y))
	var pos: Vector2
	if rand <= rect.x:
		pos = Vector2(rand, 0)
	elif rand <= rect.x + rect.y:
		pos = Vector2(rect.x, rand - rect.x)
	elif rand <= 2 * rect.x + rect.y:
		pos = Vector2(rand - rect.x - rect.y, rect.y)
	else:
		pos = Vector2(0, rand - (2 * rect.x + rect.y))

	pos -= rect / 2
	pos += Global.get_player().position

	var enemy: Enemy
	if randi() % 10 == 9:
		enemy = ENEMY_BOSS_SEGFAULT.instantiate()
	else:
		enemy = ENEMY_GODOT.instantiate()
	enemy.position = pos
	add_child(enemy)
