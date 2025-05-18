extends Control

func _ready():
	$BarTop.update_title("Settings")
	update_audio_toggle()
	$CenterContainer/GridContainer/ItemColorListP1.set_selected_color(GameSettings.color_p1)
	$CenterContainer/GridContainer/ItemColorListP2.set_selected_color(GameSettings.color_p2)
	for item_index in $CenterContainer/GridContainer/OptionGameRounds.item_count:
		var item_text = $CenterContainer/GridContainer/OptionGameRounds.get_item_text(item_index)
		if item_text == str(GameSettings.rounds):
			$CenterContainer/GridContainer/OptionGameRounds.select(item_index)
	pass

func update_audio_toggle():
	if $CenterContainer/GridContainer/AudioCheck.button_pressed == Beeper.sound_enabled:
		return
	$CenterContainer/GridContainer/AudioCheck.button_pressed = Beeper.sound_enabled
	pass

func _on_audio_check_toggled(toggled_on: bool) -> void:
	Beeper.sound_enabled = toggled_on
	update_audio_toggle()
	if Beeper.sound_enabled:
		Beeper.play_ui()
	pass

func _on_item_color_list_p_1_on_color_selected(color: Color) -> void:
	$CenterContainer/GridContainer/HBoxContainer/ColorSquareP1.set_swatch_color(color)
	Beeper.play_ui()
	GameSettings.color_p1 = color
	pass

func _on_item_color_list_p_2_on_color_selected(color: Color) -> void:
	$CenterContainer/GridContainer/HBoxContainer2/ColorSquareP2.set_swatch_color(color)
	Beeper.play_ui()
	GameSettings.color_p2 = color
	pass

func _on_option_game_rounds_item_selected(index: int) -> void:
	var value = $CenterContainer/GridContainer/OptionGameRounds.get_item_text(index)
	Beeper.play_ui()
	GameSettings.rounds = int(value)
	pass
