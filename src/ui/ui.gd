class_name Ui
extends Control

const MENU = preload("uid://cpofklbo6xjew")

var time_elapsed: float = 0.0
var minutes: int
var seconds: int
var paused: bool = false

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	minutes = int(time_elapsed / 60)
	seconds = int(time_elapsed) % 60
	%TimerLabel.text = "%02d:%02d" % [minutes, seconds]


func set_game_over(state: bool) -> void:
	%GameOverLabel.visible = state
	%Menu.visible = state
	if state:
		%MenuButton.grab_focus()


func set_kill_count(amount: int) -> void:
	%KillCountLabel.text = "Kills: %s" % amount


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		paused = not paused
		%Menu.visible = paused
		%MenuButton.grab_focus()
		get_tree().paused = paused


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(MENU)
