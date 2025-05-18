extends Node2D

@export var Ball_Speed: int = 0
@export var Ball_Speedup: int = 0

var ball_age = 0

func set_ball_speed(speed: int):
	Ball_Speed = speed
	$RigidBodyBall.set_speed(Ball_Speed)
	pass
	
func set_ball_speedup(speedup: int):
	Ball_Speedup = speedup
	pass

func kick_off(direction: Vector2) -> void:
	var current_speed = $RigidBodyBall.get_speed()
	if current_speed == 0:
		Beeper.play_hit()
		$RigidBodyBall.linear_velocity = direction
	pass

func center_offset() -> Vector2:
	var radius = $RigidBodyBall/CollisionShape2D.shape.radius
	return Vector2(radius, radius)
	
func _physics_process(delta: float) -> void:
	ball_age = ball_age+delta
	$RigidBodyBall.set_speed(Ball_Speed+ball_age*Ball_Speedup)
	pass
