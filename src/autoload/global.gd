extends Node

signal game_over

@onready var ui: Ui
var kill_count: int = 0:
	set(value):
		kill_count = value
		if ui:
			ui.set_kill_count(value)

		if value % 51 == 50:
			get_player().weapon.fire_amount += 1

func _ready() -> void:
	game_over.connect(_on_game_over_emitted)

func get_player() -> Player:
	return get_tree().root.get_node("Game/Player") as Player

func get_ui() -> Ui:
	return ui

func _on_game_over_emitted() -> void:
	get_ui().set_game_over(true)
	get_tree().paused = true
