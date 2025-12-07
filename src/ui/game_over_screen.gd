extends VBoxContainer


func _ready() -> void:
	%MenuButton.grab_focus()
	%ScoreLabel.text = "Your score: %s" % (Global.player.level * Global.ui.kills + Global.player.xp)
	%XpLabel.text = "You gathered %s XP" % Global.player.xp
	%KillsLabel.text = "You killed %s enemies" % Global.ui.kills


func _on_menu_button_pressed() -> void:
	Global.return_to_menu()
