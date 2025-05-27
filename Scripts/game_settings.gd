extends SaveableNode

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
			
			pass
	pass
