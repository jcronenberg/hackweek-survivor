extends Node

signal game_over

const GAME = preload("uid://dgo4jknqxinhf")
const MENU = preload("uid://cpofklbo6xjew")
const LOOT_TABLE = preload("uid://c0yrt5u4uw6ec")

var loot_table: LootTable
var in_game: bool = false
var game: Game
var menu: Menu
var player: Player:
	get():
		if not in_game:
			return null

		if game:
			return game.get_player()

		# I don't like this but the scene_changed signal unfortunately gets
		# called to late.
		return get_node("/root/Game").get_player()
var ui: Ui:
	get():
		if not in_game:
			return null

		if game:
			return game.get_ui()

		return get_node("/root/Game").get_ui()
var projectile_node:
	get():
		if not in_game:
			return null

		if game:
			return game.get_projectile_node()

		return get_node("/root/Game").get_projectile_node()


var kill_count: int = 0:
	set(value):
		kill_count = value
		if ui:
			ui.set_kill_count(value)


func _ready() -> void:
	game_over.connect(_on_game_over_emitted)
	get_tree().scene_changed.connect(_set_current_scene)


func return_to_menu() -> void:
	in_game = false
	get_tree().paused = false
	get_tree().change_scene_to_packed(MENU)


func start_game() -> void:
	in_game = true
	get_tree().change_scene_to_packed(GAME)


func init_loot_table() -> void:
	if loot_table:
		loot_table.queue_free()

	loot_table = LOOT_TABLE.instantiate()


func _on_game_over_emitted() -> void:
	ui.set_game_over()
	get_tree().paused = true


func _set_current_scene() -> void:
	var cur_scene = get_tree().current_scene
	menu = null
	game = null

	if cur_scene is Game:
		game = cur_scene
	elif cur_scene is Menu:
		menu = cur_scene
