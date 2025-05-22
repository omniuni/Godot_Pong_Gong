class_name ItemBall
extends Node2D

@export var Ball_Speed: int = 0:
	set(value):
		Ball_Speed = value
		if ball_age > 0:
			body_ball.set_speed(Ball_Speed)
		pass
@export var Ball_Speedup: int = 0

@onready var body_ball: RigidBody2D = $RigidBodyBall

var ball_age = -1

func _ready() -> void:
	ball_age = 0
	pass
	
func set_ball_speedup(speedup: int):
	Ball_Speedup = speedup
	pass

func kick_off(direction: Vector2) -> void:
	var current_speed = body_ball.get_speed()
	if current_speed == 0:
		Beeper.play_hit()
		body_ball.linear_velocity = direction
	pass

func center_offset() -> Vector2:
	var pre_ready_collider = $RigidBodyBall/CollisionShape2D
	var radius = pre_ready_collider.shape.radius
	return Vector2(radius, radius)
	
func _physics_process(delta: float) -> void:
	ball_age = ball_age+delta
	body_ball.set_speed(Ball_Speed+ball_age*Ball_Speedup)
	pass
