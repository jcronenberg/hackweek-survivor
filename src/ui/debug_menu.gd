extends VBoxContainer


func _on_level_up_button_pressed() -> void:
	var player: Player = Global.get_player()
	player.xp += player.next_level - player.xp


func _on_spawn_amount_button_pressed() -> void:
	get_node("/root/Game").spawn_amount += 1
