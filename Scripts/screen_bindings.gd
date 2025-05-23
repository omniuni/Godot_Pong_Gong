extends Control

func _on_bar_top_on_secondary_action() -> void:
	Scenes.change_to(get_tree(), Scenes.settings)
	pass
