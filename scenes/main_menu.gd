extends Control

@export var scene: PackedScene

func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_play_pressed() -> void:
	var scene = scene.instantiate()
	get_tree().root.add_child(scene)
	get_tree().root.remove_child(self)
	queue_free() # delete main menu
