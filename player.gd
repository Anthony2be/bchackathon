extends CharacterBody2D

@export var speed = 500
@export var grav = 30;
@export var jump = 500
@export var jump_count = 2

func _physics_process(delta: float):
	if !is_on_floor():
		velocity.y = min(velocity.y + grav, 1000)
		print(velocity.y)
	else: 
		jump_count = 2
		
	if Input.is_action_just_pressed("Jump") && jump_count > 0:
		jump_count -= 1
		velocity.y = -jump
	
	var horiz = Input.get_axis("Move Left", "Move Right")
	velocity.x = horiz * speed
	move_and_slide()
