extends VBoxContainer


func _ready() -> void:
	%MenuButton.grab_focus()
	%ScoreLabel.text = "Your score: %s" % (Global.player.level * Global.ui.kills + Global.player.xp)
	%TimeLabel.text = "You survived for %s" % Global.ui.get_time_string()
	%KillsLabel.text = "killed %s enemies" % Global.ui.kills
	%XpLabel.text = "and gathered %s XP" % Global.player.xp


func _on_menu_button_pressed() -> void:
	Global.return_to_menu()
