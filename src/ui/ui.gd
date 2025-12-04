class_name Ui
extends Control

const GAME_OVER_SCREEN = preload("uid://dtoedoqiavd80")
const PAUSE_MENU = preload("uid://c3o5b2h8xwx15")
const SETTINGS_MENU = preload("uid://cv2uajd0ywiqa")

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


func set_xp_amount(amount: int) -> void:
	%XpLabel.text = "XP: %s" % amount


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause_menu()


func toggle_pause_menu() -> void:
	paused = not paused
	%Menu.visible = paused
	get_tree().paused = paused

	if paused:
		_add_pause_menu()


func _clear_menu_container() -> void:
	for child in %MenuContainer.get_children():
		child.queue_free()


func _add_pause_menu() -> void:
	_clear_menu_container()
	var pause_menu = PAUSE_MENU.instantiate()
	pause_menu.connect("settings_requested", _add_settings_menu)
	%MenuContainer.add_child(pause_menu)


func _add_settings_menu() -> void:
	_clear_menu_container()
	var settings_menu = SETTINGS_MENU.instantiate()
	settings_menu.connect("return_requested", _add_pause_menu)
	%MenuContainer.add_child(settings_menu)
