extends Control

func _on_button_done_pressed() -> void:
	Beeper.play_ui()
	Scenes.change_to(get_tree(), Scenes.menu)
	pass

func update_title(title: String):
	var labelTitle = $PanelContainer/MarginContainer/Title
	labelTitle.text = title
	pass
