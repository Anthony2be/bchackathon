extends CharacterBody2D

@export var point1: Marker2D
@export var point2: Marker2D

@export var speed = 100
@export var grav = 30

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	navigation_agent_2d.target_position = point1.global_position
	sprite.play("default")
	timer.start()

func _physics_process(_delta: float):
	point1.position.y = global_position.y
	point2.position.y = global_position.y
	if !is_on_floor():
		velocity.y = min(velocity.y + grav, 1000)
	#navigation_agent_2d.distance_to_target()
	#navigation_agent_2d.target_position = point1.global_position
	#if navigation_agent_2d.target_reached:
		
		#print("reached")
		#timer.start()
	var dir = Vector2.ZERO
	dir = navigation_agent_2d.get_next_path_position() - global_position
	dir = dir.normalized().x
	dir = 0 if is_equal_approx(dir, 0) else dir
	
	if dir < 0:
		sprite.flip_h = true
	elif dir > 0: 
		sprite.flip_h = false
	
	if !navigation_agent_2d.is_target_reached():
		velocity.x = dir * speed
	
	if velocity.x > -1 && velocity.x < 1:
		sprite.play("default")
	
		
	#if navigation_agent_2d.target_reached:
		#print("reached")
	
	move_and_slide()

func _on_timer_timeout() -> void:
	if navigation_agent_2d.target_reached:
		print("runnin")
		sprite.play("Running")
		if navigation_agent_2d.target_position == point1.global_position:
			navigation_agent_2d.target_position = point2.global_position
		else:
			navigation_agent_2d.target_position = point1.global_position
	print('started')
	#timer.stop()


func _on_navigation_agent_2d_target_reached() -> void:
	print("reached")
	timer.start()
