extends Node

@onready var player_cam: Camera2D = $Player/Camera2D
@onready var ui: Control = $UI
@onready var ui_cam: Camera2D = $UI/Camera2D2
@onready var level_1: Node2D = $Level1
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	ui.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("UI"):
		ui.visible = !ui.visible
		level_1.visible = !level_1.visible
		ui_cam.enabled = !ui_cam.enabled
		player.visible = !player.visible
		player.process_mode = Node.PROCESS_MODE_INHERIT
		if (ui_cam.enabled):
			player.process_mode = Node.PROCESS_MODE_DISABLED
			ui_cam.make_current()
