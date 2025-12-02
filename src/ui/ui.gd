class_name Ui
extends Control

var time_elapsed: float = 0.0
var minutes: int
var seconds: int

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	minutes = int(time_elapsed / 60)
	seconds = int(time_elapsed) % 60
	%TimerLabel.text = "%02d:%02d" % [minutes, seconds]


func set_game_over(state: bool) -> void:
	%GameOverLabel.visible = state
