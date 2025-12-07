extends VBoxContainer


func _on_level_up_button_pressed() -> void:
	var player: Player = Global.player
	player.xp += player.next_level - player.xp


func _on_spawn_amount_button_pressed() -> void:
	Global.game.spawn_amount += 1


func _on_max_level_button_pressed() -> void:
	Global.player.set_to_max_level()
