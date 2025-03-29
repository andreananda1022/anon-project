extends CharacterBody2D

@onready var AnimatedPlayer: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 50
@export var acceleration: float = 100
@export var friction: float = 200

var input = Vector2.ZERO

func _physics_process(delta: float) -> void:
	player_movement(delta)
	player_animation()

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func player_animation():
	input = get_input()
	if input.y > 0:
		AnimatedPlayer.play("down")
	elif input.x > 0:
		AnimatedPlayer.play("right")
	elif input.y < 0:
		AnimatedPlayer.play("up")
	elif input.x < 0:
		AnimatedPlayer.play("left")
	else:
		AnimatedPlayer.play("idle")

func player_movement(delta):
	input = get_input()
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * acceleration * delta)
		velocity = velocity.limit_length(speed)
	move_and_slide()
