extends Control


func _ready() -> void:
	%PlayButton.grab_focus()


func _on_play_button_pressed() -> void:
	Global.start_game()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
