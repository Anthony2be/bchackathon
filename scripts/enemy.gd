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
	#timer.start()
	navigation_agent_2d.target_desired_distance = 20

func _physics_process(_delta: float):
	point1.position.y = global_position.y
	point2.position.y = global_position.y
	if !is_on_floor():
		velocity.y = min(velocity.y + grav, 1000)
	
	if !navigation_agent_2d.is_navigation_finished():
		
		if (navigation_agent_2d.target_position.x - global_position.x) < 0:
			velocity.x = -speed
		else:
			velocity.x = speed
	else:
		print("reached")
		velocity = Vector2.ZERO
		position = navigation_agent_2d.target_position
	
	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	#if navigation_agent_2d.target_reached:
		#print("reached")
	
	move_and_slide()

func _on_timer_timeout() -> void:
	if navigation_agent_2d.target_reached:
		#print("runnin")
		sprite.play("Running")
		if navigation_agent_2d.target_position == point1.global_position:
			navigation_agent_2d.target_position = point2.global_position
		else:
			navigation_agent_2d.target_position = point1.global_position
	#print('started')
	#timer.stop()


func _on_navigation_agent_2d_target_reached() -> void:
	#print("reached")
	sprite.play("default")
	timer.start()
