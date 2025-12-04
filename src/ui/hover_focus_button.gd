class_name HoverFocusButton
extends Button


func _ready() -> void:
	mouse_entered.connect(grab_focus)
