extends Node2D

@export var Light_Color = Color(1, 1, 1)
@export var Speed_In_Pixels = 0
@export var Key_Filter_Up = ""
@export var Key_Filter_Down = ""

var going_up = false
var going_down = false
var computed_vertical_velocity = 0
var last_known_linear_velovity = 0

signal kick(direction: Vector2)

func _ready() -> void:
	$RigidBodyPanel/Polygon2DLightTop.color = Light_Color
	$RigidBodyPanel/Polygon2DLightBottom.color = Light_Color
	pass
	
func set_light_color(color: Color):
	Light_Color = color
	_ready()
	pass

func _physics_process(delta: float) -> void:
	var linear_velocity_y = computed_vertical_velocity*Speed_In_Pixels
	if linear_velocity_y != last_known_linear_velovity:
		$RigidBodyPanel.linear_velocity.y = linear_velocity_y
		last_known_linear_velovity = linear_velocity_y
	$RigidBodyPanel.linear_velocity.x = 0
	pass
	
func _input(event: InputEvent) -> void:
	var event_name = get_action_name(event)
	var should_compute = false
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

func get_action_name(event: InputEvent):
	var eventString = null
	for eventName in InputMap.get_actions():
		if event.is_action(eventName):
			return eventName
	return eventString
	pass
	

func _on_rigid_body_panel_body_entered(body: Node) -> void:
	if body.get_parent().name.contains("Ball"):
		Beeper.play_hit()
	pass
