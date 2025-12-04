class_name Ui
extends Control

const GAME_OVER_SCREEN = preload("uid://dtoedoqiavd80")
const PAUSE_MENU = preload("uid://c3o5b2h8xwx15")

var time_elapsed: float = 0.0
var minutes: int
var seconds: int
var paused: bool = false

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	minutes = int(time_elapsed / 60)
	seconds = int(time_elapsed) % 60
	%TimerLabel.text = "%02d:%02d" % [minutes, seconds]


func set_game_over() -> void:
	var game_over_screen = GAME_OVER_SCREEN.instantiate()
	%Menu.visible = true
	%MenuContainer.add_child(game_over_screen)


func set_kill_count(amount: int) -> void:
	%KillCountLabel.text = "Kills: %s" % amount


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause_menu()


func toggle_pause_menu() -> void:
	paused = not paused
	%Menu.visible = paused
	get_tree().paused = paused

	if paused:
		_clear_menu_container()
		%MenuContainer.add_child(PAUSE_MENU.instantiate())


func _clear_menu_container() -> void:
	for child in %MenuContainer.get_children():
		child.queue_free()
