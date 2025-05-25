extends Area2D

@export var milk : PackedScene

@onready var upper_left: Marker2D = $UpperLeft
@onready var bottom_right: Marker2D = $BottomRight
@onready var spawn_timer: Timer = $SpawnTimer


func spawn() -> void:
	randomize()
	var upper = upper_left.global_position
	var lower = bottom_right.global_position
	var thing = milk.instance()
	thing.position.x = position.x + lerp(upper.x, lower.x, randf())
	thing.position.y = position.y + lerp(lower.y, upper.y, randf())
	get_parent().add_child(thing)



func _on_spawn_timer_timeout() -> void:
	spawn_timer.start()
	spawn()
