extends VBoxContainer

signal settings_requested


func _ready() -> void:
	%PlayButton.grab_focus()


func _on_play_button_pressed() -> void:
	Global.start_game()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_settings_button_pressed() -> void:
	settings_requested.emit()
