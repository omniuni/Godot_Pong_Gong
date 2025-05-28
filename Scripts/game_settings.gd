extends SaveableNode

var Display_Fullscreen: bool = false:
	set(value):
		Display_Fullscreen = value
		_save()
		pass

var Audio_Enabled: bool = true:
	set(value):
		Audio_Enabled = value
		_save()
		pass

var Rounds: int = 3:
	set(value):
		Rounds = value
		_save()
		pass

var Color_P1: Color = Color(0,0,0):
	set(value):
		Color_P1 = value
		_save()
		pass
var Color_P2: Color = Color(.5,.5,.5):
	set(value):
		Color_P2 = value
		_save()
		pass
		
var Custom_Key_Bindings: Dictionary = {}:
	set(value):
		Custom_Key_Bindings = value
		_save()
		pass
		
func apply_custom_key_bindings() -> void:
	InputMap.load_from_project_settings()
	for action in InputMap.get_actions():
		if Custom_Key_Bindings.has(action):
			InputMap.action_erase_events(action)
			var new_event: InputEventKey = InputEventKey.new()
			new_event.keycode = Custom_Key_Bindings.get(action)
			InputMap.action_add_event(action, new_event)
			pass
	pass

func get_action_name(event: InputEvent) -> String:
	var event_string = null
	for event_name in InputMap.get_actions():
		if event.is_action(event_name):
			return event_name
	if event_string == null:
		event_string = ""
	return event_string

func apply_display() -> void:
	var current_mode = DisplayServer.window_get_mode()
	if Display_Fullscreen and current_mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if not Display_Fullscreen and current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass
