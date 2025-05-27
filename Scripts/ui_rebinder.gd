extends Control

var read_time: float = 0.0

@export var Input_Read_Time: float = 1.0

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

@onready
var read_progress: ProgressBar = $MarginContainer/HBoxContainer/HBoxContainer/ContainerCustom/ProgressBar
@onready
var button_custom: Button = $MarginContainer/HBoxContainer/HBoxContainer/ContainerCustom/ButtonCustom
		
func _ready() -> void:
	var button_default: Button = $MarginContainer/HBoxContainer/HBoxContainer/ContainerDefault/ButtonDefault
	var rebinder_label: Label = $MarginContainer/HBoxContainer/Label
	
	rebinder_label.text = ""
	read_progress.max_value = Input_Read_Time
	
	InputMap.load_from_project_settings()
	
	for action in InputMap.get_actions():
		if action == Action_to_Rebind:
			rebinder_label.text = action
			var input_events: Array[InputEvent] = InputMap.action_get_events(action)
			var input_list = ""
			for input_event: InputEvent in input_events:
				input_list+=input_event.as_text().replace("(Physical)", "")+", "
				pass
			button_default.text = input_list.trim_suffix(", ").strip_edges()
		pass
	
	if GameSettings.Custom_Key_Bindings.has(Action_to_Rebind):
		var restored_event = InputEventKey.new()
		restored_event.keycode = GameSettings.Custom_Key_Bindings[Action_to_Rebind]
		button_custom.text = restored_event.as_text().replace("(Physical)", "")
		
	if not Action_Name.strip_edges().is_empty():
		rebinder_label.text = Action_Name
	
	pass
	
func _input(event: InputEvent) -> void:
	if read_time == 0 or event is InputEventMouse:
		return
	if event.as_text() == "Delete":
		GameSettings.Custom_Key_Bindings.erase(Action_to_Rebind)
	else:
		GameSettings.Custom_Key_Bindings[Action_to_Rebind] = event.keycode
	GameSettings._save()
	Beeper.play_hit()
	read_time = 0
	read_progress.visible = false
	button_custom.disabled = false
	update_custom()
	pass

func update_custom() -> void:
	if not GameSettings.Custom_Key_Bindings.has(Action_to_Rebind):
		button_custom.text = " "
	else:
		var restored_event = InputEventKey.new()
		restored_event.keycode = GameSettings.Custom_Key_Bindings[Action_to_Rebind]
		button_custom.text = restored_event.as_text().replace("(Physical)", "")
	pass
	
func update_progress() -> void:
	if read_time == 0:
		return
	if read_time > 0:
		read_time = read_time-0.2
	if read_time < 0:
		read_time = 0
	if read_time >= 0:
		read_progress.value = read_time
	if read_time == 0:
		read_progress.visible = false
		button_custom.disabled = false
	pass

func _on_timer_timeout() -> void:
	update_progress()
	pass

func _on_button_custom_pressed() -> void:
	read_time = Input_Read_Time
	read_progress.value = read_time
	button_custom.disabled = true
	read_progress.visible = true
	Beeper.play_ui()
	pass
