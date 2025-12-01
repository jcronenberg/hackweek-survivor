extends Node

signal game_over

func _ready() -> void:
	game_over.connect(_on_game_over_emitted)

func get_player() -> Player:
	return get_tree().root.get_node("Game/Player") as Player

func get_ui() -> Ui:
	return get_tree().root.get_node("Game/CanvasLayer/Ui") as Ui

func _on_game_over_emitted() -> void:
	get_ui().set_game_over(true)
	get_tree().paused = true
