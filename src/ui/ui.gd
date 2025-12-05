class_name Ui
extends Control

const GAME_OVER_SCREEN = preload("uid://dtoedoqiavd80")
const PAUSE_MENU = preload("uid://c3o5b2h8xwx15")
const SETTINGS_MENU = preload("uid://cv2uajd0ywiqa")
const UPGRADE_MENU = preload("uid://dkuwh37hxwif3")

enum UI_STATES {RUNNING, PAUSED, UPGRADING}

var time_elapsed: float = 0.0
var minutes: int
var seconds: int
var state: UI_STATES = UI_STATES.RUNNING


func _ready() -> void:
	set_max_xp(Global.get_player().level_requirement)
	if OS.has_feature("editor"):
		%DebugMenu.visible = true


func _physics_process(delta: float) -> void:
	if state == UI_STATES.RUNNING:
		time_elapsed += delta
		minutes = int(time_elapsed / 60)
		seconds = int(time_elapsed) % 60
		%TimerLabel.text = "%02d:%02d" % [minutes, seconds]


func set_game_over() -> void:
	_clear_menu_container()
	state = UI_STATES.PAUSED
	var game_over_screen = GAME_OVER_SCREEN.instantiate()
	%Menu.visible = true
	%MenuContainer.add_child(game_over_screen)


func set_kill_count(amount: int) -> void:
	%KillCountLabel.text = "Kills: %s" % amount


func set_xp_amount(amount: int) -> void:
	%XpBar.value = amount


func set_max_xp(value: int) -> void:
	%XpBar.min_value = %XpBar.max_value
	%XpBar.max_value = value


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause_menu()


func toggle_pause_menu() -> void:
	if state == UI_STATES.RUNNING:
		state = UI_STATES.PAUSED
	elif state == UI_STATES.PAUSED:
		state = UI_STATES.RUNNING
	else:
		return

	if state == UI_STATES.PAUSED:
		%Menu.visible = true
		get_tree().paused = true
		_add_pause_menu()
	else:
		_hide_menu()


func show_upgrade() -> void:
	state = UI_STATES.UPGRADING
	_clear_menu_container()

	var upgrade_menu = UPGRADE_MENU.instantiate()
	upgrade_menu.item_selected.connect(_hide_menu)
	%MenuContainer.add_child(upgrade_menu)

	%Menu.visible = true
	%Fireworks.visible = true
	get_tree().paused = true


func _clear_menu_container() -> void:
	for child in %MenuContainer.get_children():
		child.queue_free()


func _hide_menu() -> void:
	state = UI_STATES.RUNNING
	%Menu.visible = false
	%Fireworks.visible = false
	get_tree().paused = false
	_clear_menu_container()



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
