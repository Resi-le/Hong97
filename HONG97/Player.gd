extends CharacterBody2D

@export var speed: float = 150.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_direction = Vector2(0, 1)

func _physics_process(delta: float) -> void:
	var input_direction = Vector2.ZERO
	if Input.is_action_pressed("Movement-Right"):
		input_direction.x += 1
	if Input.is_action_pressed("Movement-Left"):
		input_direction.x -= 1
	if Input.is_action_pressed("Movement-Down"):
		input_direction.y += 1
	if Input.is_action_pressed("Movement-Up"):
		input_direction.y -= 1

	# Normalize input direction
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
		last_direction = input_direction
		velocity = input_direction * speed
	else:
		velocity = Vector2.ZERO
	update_animation()
	move_and_slide()

func update_animation() -> void:
	var animation_name = ""

	if velocity.length() > 0:
		if abs(last_direction.x) > abs(last_direction.y):
			if last_direction.x > 0:
				animation_name = "Movement-Right"
			else:
				animation_name = "Movement-Left"
		else:
			# 수직 이동이 더 크거나 같을 때
			if last_direction.y > 0:
				animation_name = "Movement-Idle"
			else:
				animation_name = "Movement-Up"
	else:
		if abs(last_direction.x) > abs(last_direction.y):
			if last_direction.x > 0:
				animation_name = "Movement-Idle"
			else:
				animation_name = "Movement-Idle"
		else:
			if last_direction.y > 0:
				animation_name = "Movement-Idle"
			else:
				animation_name = "Movement-Idle"
	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)
