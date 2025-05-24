extends Control

@export var Action_to_Rebind: String = "":
	set(value):
		Action_to_Rebind = value
		_ready()
		pass
		
@export var Action_Name: String = "":
	set(value):
		Action_Name = value
		_ready()
		pass
		
func _ready() -> void:
	var button_default: Button = $MarginContainer/HBoxContainer/HBoxContainer/ButtonDefault
	var rebinder_label: Label = $MarginContainer/HBoxContainer/Label
	rebinder_label.text = ""
	
	InputMap.load_from_project_settings()
	
	for action in InputMap.get_actions():
		if action == Action_to_Rebind:
			rebinder_label.text = action
			var input_events = InputMap.action_get_events(action)
			var input_list = ""
			for input_event in input_events:
				input_list+=input_event.as_text().replace("(Physical)", "")+", "
				pass
			button_default.text = input_list.trim_suffix(", ").strip_edges()
		pass
	
	if not Action_Name.is_empty():
		rebinder_label.text = Action_Name
		
	
	
	pass
