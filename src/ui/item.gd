class_name Item
extends PanelContainer

signal pressed


func _on_button_pressed() -> void:
	pressed.emit()


func _on_focus_entered() -> void:
	%Button.grab_focus()
