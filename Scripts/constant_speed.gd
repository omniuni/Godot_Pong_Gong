extends RigidBody2D

@export var Constant_Speed = 0

var magnitude = 0

func set_speed(speed):
	Constant_Speed = speed
	pass
	
func get_speed():
	return magnitude

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	magnitude = sqrt(state.linear_velocity.x**2+state.linear_velocity.y**2)
	if magnitude != 0:
		var multiplier = Constant_Speed/magnitude
		var newX = state.linear_velocity.x*multiplier
		var newY = state.linear_velocity.y*multiplier
		state.linear_velocity = Vector2(newX, newY)
	pass
