extends VBoxContainer

signal return_requested

const VOLUME_SCALE = 50

func _ready() -> void:
	%VolumeSlider.grab_focus()
	%VolumeSlider.value = AudioServer.get_bus_volume_linear(0) * VOLUME_SCALE


func _on_return_button_pressed() -> void:
	return_requested.emit()


func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value / VOLUME_SCALE)
