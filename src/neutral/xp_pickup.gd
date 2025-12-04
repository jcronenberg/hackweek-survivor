class_name XpPickup
extends Pickup

var xp_amount: int = 1


func _ready() -> void:
	scale += Vector2(xp_amount * 0.1, xp_amount * 0.1)


func pick_up(player_pos: Vector2) -> void:
	set_process(false)
	set_physics_process(false)
	%AudioStreamPlayer.play()
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", (player_pos + global_position) / 2, 0.05)
	tween.tween_property(self, "modulate:v", 1, 0.05).from(10)
	tween.tween_property(self, "scale", scale * 2, 0.05)
	tween.tween_callback(queue_free)
