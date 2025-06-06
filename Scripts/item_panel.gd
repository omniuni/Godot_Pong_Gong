class_name ItemPanel
extends Node2D

@export var Speed_In_Pixels = 0
@export var Key_Filter_Up = ""
@export var Key_Filter_Down = ""

@export var Light_Color = Color(1, 1, 1):
	set(value):
		Light_Color = value
		_ready()
		pass

var going_up = false
var going_down = false
var computed_vertical_velocity = 0
var last_known_linear_velovity = 0
var move_to_target

@onready
var light_top_rect: ColorRect = $RigidBodyPanel/LightTopRect
@onready
var light_bottom_rect: ColorRect = $RigidBodyPanel/LightBottomRect
@onready
var panel_body: RigidBody2D = $RigidBodyPanel
@onready
var panel_collision_area: CollisionShape2D = $RigidBodyPanel/CollisionShapePanel

signal kick(direction: Vector2)

func _ready() -> void:
	light_top_rect.color = Light_Color
	light_bottom_rect.color = Light_Color
	pass

func _physics_process(_delta: float) -> void:
	if move_to_target != null:
		request_move_to(move_to_target)
	var linear_velocity_y = computed_vertical_velocity*Speed_In_Pixels
	if linear_velocity_y != last_known_linear_velovity:
		panel_body.linear_velocity.y = linear_velocity_y
		last_known_linear_velovity = linear_velocity_y
	panel_body.linear_velocity.x = 0
	pass
	
func request_move_to(target_global_position: Vector2) -> void:
	if move_to_target == null or move_to_target != target_global_position:
		move_to_target = target_global_position
	var panel_center = panel_collision_area.global_position
	# Reduce jitter if it's close enough
	if abs(target_global_position.y-panel_center.y) < 3:
		request_move_stop()
		return
	if target_global_position.y < panel_center.y:
		going_up = true
	if target_global_position.y > panel_center.y:
		going_down = true
	compute_velocity()
	pass
	
func request_move_stop() -> void:
	going_up = false
	going_down = false
	move_to_target = null
	compute_velocity()
	pass
	
func _input(event: InputEvent) -> void:
	var event_name: String = GameSettings.get_action_name(event)
	var should_compute: bool = false
	if Key_Filter_Down == "" or Key_Filter_Up == "":
		return
	if event_name != null:
		if event_name.contains(Key_Filter_Up):
			if event.is_pressed():
				going_up = true
			else:
				going_up = false
			should_compute = true
		elif(event_name.contains(Key_Filter_Down)):
			if event.is_pressed():
				going_down = true
			else:
				going_down = false
			should_compute = true
	if should_compute:
		compute_velocity()
	pass

func compute_velocity() -> void:
	var velocity = 0
	if going_down:
		velocity = velocity+1
	if going_up:
		velocity = velocity-1
	computed_vertical_velocity = velocity
	if computed_vertical_velocity != 0:
		kick.emit(Vector2(0,computed_vertical_velocity))
	pass

func _on_rigid_body_panel_body_entered(body: Node) -> void:
	if body.get_parent().name.contains("Ball"):
		Beeper.play_hit()
	pass
