@tool
class_name UiBarTop
extends Control

## This Script powers the common top-bar menu item.
## there is a universal "Main Menu" button, and
## callbacks for secondary and tertiary actions.
## The bar hides the second and third buttons
## if no text is supplied.
## The control is marked as a @tool, allowing live
## preview in the editor.

@export var Title: String = "Title Bar":
	set(value):
		Title = str(value)
		_ready()
		pass

@export var Show_Menu_Button: bool = true:
	set(value):
		Show_Menu_Button = value
		_ready()
		pass

@export var Action_Two: String = "":
	set(value):
		Action_Two = str(value)
		_ready()
		pass
		
@export var Action_Three: String = "":
	set(value):
		Action_Three = str(value)
		_ready()
		pass

signal On_Secondary_Action
signal On_Tertiary_Action

func _ready() -> void:
	var buttonTitle = $PanelContainer/MarginContainer/Title
	var buttonMainMenu = $PanelContainer/MarginContainer/HBoxContainer/ButtonDone
	var buttonSecondary: Button = $PanelContainer/MarginContainer/HBoxContainer/ButtonSecondary
	var buttonTertiary = $PanelContainer/MarginContainer/HBoxContainer/ButtonTertiary
	buttonTitle.text = Title
	buttonSecondary.text = Action_Two
	buttonTertiary.text = Action_Three
	buttonMainMenu.visible = Show_Menu_Button
	buttonSecondary.visible = not Action_Two.is_empty()
	buttonTertiary.visible = not Action_Three.is_empty()
	pass

func _on_button_done_pressed() -> void:
	Beeper.play_ui()
	Scenes.change_to(get_tree(), Scenes.menu)
	pass

func _on_button_secondary_pressed() -> void:
	Beeper.play_ui()
	On_Secondary_Action.emit()
	pass

func _on_button_tertiary_pressed() -> void:
	Beeper.play_ui()
	On_Tertiary_Action.emit()
	pass
