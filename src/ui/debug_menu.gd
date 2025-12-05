extends VBoxContainer


func _on_level_up_button_pressed() -> void:
	var player: Player = Global.get_player()
	player.xp += player.next_level - player.xp
