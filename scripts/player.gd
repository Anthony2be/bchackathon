class_name Player
extends CharacterBody2D

@export var speed = 500
@export var grav = 30
@export var jump = 500
@export var jump_count = 2

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	sprite.play("default")
	
func animation_manager():
	if Input.is_action_pressed("Move Left"):
		sprite.flip_h = false
	elif Input.is_action_pressed("Move Right"):
		sprite.flip_h = true
		
	if !is_on_floor():
		sprite.play("jump")
	elif Input.is_action_pressed("Move Left") || Input.is_action_pressed("Move Right"):
		sprite.play("walking")
	else:
		sprite.play("default")
		
func _process(_delta: float):
	animation_manager()

func _physics_process(_delta: float):
	if !is_on_floor():
		velocity.y = min(velocity.y + grav, 1000)
		#print(velocity.y)
	else:
		jump_count = 2
		
	if Input.is_action_just_pressed("Jump") && jump_count > 0:
		jump_count -= 1
		velocity.y = -jump
		audio.play()
	
	var horiz = Input.get_axis("Move Left", "Move Right")
	velocity.x = horiz * speed
	move_and_slide()
