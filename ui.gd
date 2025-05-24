extends Control

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("UI"):
		self.visible = !self.visible
