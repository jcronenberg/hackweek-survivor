class_name Ui
extends Control

func update_player_health(new_health: int) -> void:
	%HealthLabel.text = "Health: %s" % new_health

func set_game_over(state: bool) -> void:
	%GameOverLabel.visible = state
