extends Control

## The settings screen controls values in the GameSettings singleton

var ui_setup_complete = false

func _ready():
	ui_setup_complete = false
	GameSettings._Enable_Saving = false
	update_display()
	update_audio_toggle()
	update_player_colors()
	update_rounds()
	ui_setup_complete = true
	GameSettings._Enable_Saving = true
	pass
	
func update_display():
	var options_display: OptionButton = $CenterContainer/GridContainer/DisplayOptions
	if GameSettings.Display_Fullscreen:
		for item_index: int in options_display.item_count:
			var item_text: String = options_display.get_item_text(item_index)
			if item_text.to_lower().contains("full"): options_display.select(item_index)
	else:
		for item_index: int in options_display.item_count:
			var item_text: String = options_display.get_item_text(item_index)
			if item_text.to_lower().contains("window"): options_display.select(item_index)
	pass

func update_audio_toggle():
	var buttonEnableAudio: CheckButton = $CenterContainer/GridContainer/AudioCheck
	buttonEnableAudio.button_pressed = GameSettings.Audio_Enabled
	pass
	
func update_player_colors():
	var colorListP1: UiColorList = $CenterContainer/GridContainer/ItemColorListP1
	var colorListP2: UiColorList = $CenterContainer/GridContainer/ItemColorListP2
	var colorSquareP1: UiColorSquare = $CenterContainer/GridContainer/HBoxContainer/ColorSquareP1
	var colorSquareP2: UiColorSquare = $CenterContainer/GridContainer/HBoxContainer2/ColorSquareP2
	colorListP1.Selected_Color = GameSettings.Color_P1
	colorListP2.Selected_Color = GameSettings.Color_P2
	colorSquareP1.Swatch_Color = GameSettings.Color_P1
	colorSquareP2.Swatch_Color = GameSettings.Color_P2
	pass
	
func update_rounds():
	var options_rounds: OptionButton = $CenterContainer/GridContainer/OptionGameRounds
	for item_index: int in options_rounds.item_count:
		var item_text: String = options_rounds.get_item_text(item_index)
		if item_text == str(GameSettings.Rounds):
			options_rounds.select(item_index)
	pass

func _on_audio_check_toggled(toggled_on: bool) -> void:
	GameSettings.Audio_Enabled = toggled_on
	update_audio_toggle()
	if ui_setup_complete:
		Beeper.play_ui()
	pass

func _on_item_color_list_p_1_on_color_selected(color: Color) -> void:
	var colorSquareP1: UiColorSquare = $CenterContainer/GridContainer/HBoxContainer/ColorSquareP1
	colorSquareP1.Swatch_Color = color
	GameSettings.Color_P1 = color
	if ui_setup_complete:
		Beeper.play_ui()
	pass

func _on_item_color_list_p_2_on_color_selected(color: Color) -> void:
	var colorSquareP2: UiColorSquare = $CenterContainer/GridContainer/HBoxContainer2/ColorSquareP2
	colorSquareP2.Swatch_Color = color
	GameSettings.Color_P2 = color
	if ui_setup_complete:
		Beeper.play_ui()
	pass

func _on_option_game_rounds_item_selected(index: int) -> void:
	var options_rounds: OptionButton = $CenterContainer/GridContainer/OptionGameRounds
	var value_int: int = int(options_rounds.get_item_text(index))
	GameSettings.Rounds = value_int
	if ui_setup_complete:
		Beeper.play_ui()
	pass

func _on_display_options_item_selected(index: int) -> void:
	var options_display: OptionButton = $CenterContainer/GridContainer/DisplayOptions
	var value_string: String = options_display.get_item_text(index).to_lower()
	GameSettings.Display_Fullscreen = value_string.contains("full")
	if ui_setup_complete:
		Beeper.play_ui()
	GameSettings.apply_display()
	pass

func _on_button_kb_configure_pressed() -> void:
	Beeper.play_ui()
	Scenes.change_to(get_tree(), Scenes.bindings)
	pass
