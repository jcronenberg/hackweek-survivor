extends VBoxContainer

signal settings_requested


func _ready() -> void:
	%ReturnGameButton.grab_focus()


func _on_return_game_button_pressed() -> void:
	Global.get_ui().toggle_pause_menu()


func _on_return_menu_button_pressed() -> void:
	Global.return_to_menu()


func _on_settings_button_pressed() -> void:
	settings_requested.emit()
