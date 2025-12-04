extends Control
const FIREWORK_PARTICLE = preload("uid://cgyxcg3df8dle")


func _ready() -> void:
	set_physics_process(false)


func _physics_process(_delta: float) -> void:
	var rect: Rect2 = get_rect()
	var point: Vector2 = Vector2(randf_range(0, rect.end.x), randf_range(0, rect.end.y))
	var firework = FIREWORK_PARTICLE.instantiate()
	firework.position = point
	firework.color = Color.from_hsv(randf_range(1.0, 6.0), 1.0, 1.0)
	firework.finished.connect(firework.queue_free)
	add_child(firework)
	firework.emitting = true


func _on_visibility_changed() -> void:
	set_physics_process(visible)
