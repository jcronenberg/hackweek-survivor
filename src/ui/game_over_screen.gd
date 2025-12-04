extends VBoxContainer


func _ready() -> void:
	%MenuButton.grab_focus()


func _on_menu_button_pressed() -> void:
	Global.return_to_menu()
