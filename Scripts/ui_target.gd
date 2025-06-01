extends PanelContainer

@export var Emulate_Touch_With_Mouse: bool = false
@export var Print_Debug_Messages: bool = false

signal on_target_touch(target: Vector2)
signal on_target_drag(target: Vector2)
signal on_target_end()

@onready var touch_point: Polygon2D = $Area2D/Touchpoint
@onready var drag_point: Polygon2D = $Area2D/Dragpoint
@onready var area: Area2D = $Area2D
@onready var area_shape: CollisionShape2D = $Area2D/CollisionShape2D

var is_interacting: bool = false
var is_dragging: bool = false
var last_touch: Vector2 = Vector2(-1,-1)

func _ready() -> void:
	Input.emulate_touch_from_mouse = Emulate_Touch_With_Mouse
	pass

func _input(event: InputEvent) -> void:
	
	if get_parent() == null or get_parent() is not Container:
		print_debug("ERROR: UiTarget must be placed in a container.")
		return
		
	if event is not InputEventScreenDrag and event is not InputEventScreenTouch:
		return
		
	var parent: Container = get_parent()
	var parent_rect: Rect2 = parent.get_global_rect()
	
	if not parent_rect.has_point(event.position):
		if is_interacting or is_dragging:
			if Print_Debug_Messages: print("Tracking target lost in "+parent.name)
			end_interaction()
			last_touch = Vector2(-1,-1)
		if is_interacting: is_interacting = false
		if is_dragging: is_dragging = false
		return
		
	if Print_Debug_Messages: print("Tracking target in "+parent.name)
	
	if event is InputEventScreenDrag:
		if last_touch != event.position:
			last_touch = event.position
			is_dragging = true
			is_interacting = true
			handle_interaction()
	elif event is InputEventScreenTouch and event.is_pressed():
		if not is_interacting and last_touch != event.position:
			is_interacting = true
			is_dragging = false
			last_touch = event.position
			handle_interaction()
	elif is_interacting or is_dragging:
		if event is InputEventScreenTouch:
			is_interacting = false
			is_dragging = false
			end_interaction()
	
	pass

func handle_interaction() -> void:
	if Print_Debug_Messages:
		if is_dragging: print("Drag event at "+str(last_touch))
		else: print("Touch event at "+str(last_touch))
	if is_dragging: on_target_drag.emit(last_touch)
	else: on_target_touch.emit(last_touch)
	update_visual_position()
	touch_point.visible = true
	if is_dragging: drag_point.visible = true
	pass
	
func end_interaction() -> void:
	if Print_Debug_Messages: print("Interaction ended at "+str(last_touch))
	touch_point.visible = false
	drag_point.visible = false
	last_touch = Vector2(-1,-1)
	on_target_end.emit()
	update_visual_position()
	pass

func update_visual_position() -> void:
	area.global_position = last_touch-area_shape.shape.get_rect().size/2
	pass
