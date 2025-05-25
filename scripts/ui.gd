extends Control

@onready var check_button: CheckButton = $"VBoxContainer/HBoxContainer/Jump Sound Button"

func _on_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Wondohoy"), toggled_on)
