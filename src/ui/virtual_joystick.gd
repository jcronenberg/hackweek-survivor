class_name VirtualJoystick
extends Control

const MAX_RADIUS = 80.0
const OUTER_COLOR = Color(1, 1, 1, 0.3)
const KNOB_COLOR = Color(1, 1, 1, 0.6)
const OUTER_RADIUS = MAX_RADIUS
const KNOB_RADIUS = 30.0

var deadzone: float = 0.2
var is_active: bool = false:
	set(value):
		is_active = value
		if not value:
			_reset()

var direction: Vector2 = Vector2.ZERO

var _touch_index: int = -1
var _base_pos: Vector2 = Vector2.ZERO
var _knob_pos: Vector2 = Vector2.ZERO
var _touching: bool = false


func _ready() -> void:
	anchor_right = 1.0
	anchor_bottom = 1.0
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _input(event: InputEvent) -> void:
	if not is_active:
		return

	if event is InputEventScreenTouch:
		if event.pressed and _touch_index == -1:
			if event.position.y < get_viewport_rect().size.y * 0.2:
				return
			_touch_index = event.index
			_base_pos = event.position
			_knob_pos = event.position
			_touching = true
			queue_redraw()
		elif not event.pressed and event.index == _touch_index:
			_reset()
			queue_redraw()

	elif event is InputEventScreenDrag and event.index == _touch_index:
		var offset = event.position - _base_pos
		if offset.length() > MAX_RADIUS:
			offset = offset.normalized() * MAX_RADIUS
		_knob_pos = _base_pos + offset
		var raw = offset / MAX_RADIUS
		direction = Vector2.ZERO if raw.length() < deadzone else raw
		queue_redraw()


func _draw() -> void:
	if not _touching:
		return
	draw_circle(_base_pos, OUTER_RADIUS, OUTER_COLOR)
	draw_circle(_knob_pos, KNOB_RADIUS, KNOB_COLOR)


func _reset() -> void:
	_touch_index = -1
	_touching = false
	direction = Vector2.ZERO
