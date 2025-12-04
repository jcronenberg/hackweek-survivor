extends Node

signal game_over

const GAME = preload("uid://dgo4jknqxinhf")
const MENU = preload("uid://cpofklbo6xjew")

@onready var ui: Ui
var kill_count: int = 0:
	set(value):
		kill_count = value
		if ui:
			ui.set_kill_count(value)


func _ready() -> void:
	game_over.connect(_on_game_over_emitted)


func get_player() -> Player:
	return get_tree().root.get_node("Game/Player") as Player


func get_ui() -> Ui:
	return ui


func return_to_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(MENU)


func start_game() -> void:
	get_tree().change_scene_to_packed(GAME)


func _on_game_over_emitted() -> void:
	get_ui().set_game_over()
	get_tree().paused = true
