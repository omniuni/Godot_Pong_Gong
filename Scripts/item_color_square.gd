@tool
class_name UiColorSquare
extends PanelContainer

signal On_Color_Selected(color: Color)

@export var Selectable: bool = false:
	set(value):
		Selectable = value
		_ready()
		pass

@export var Selected: bool = false:
	set(value):
		Selected = value
		_ready()
		pass

@export var Swatch_Color: Color = Color(0,0,0):
	set(value):
		Swatch_Color = value
		_ready()
		pass

func _ready() -> void:
	var swatch_color_rect: ColorRect = $MarginContainer/ColorRect
	var selected_poly_container: Control = $MarginContainer/ColorRect/Control
	var button: Button = $Button
	swatch_color_rect.color = Swatch_Color
	selected_poly_container.visible = Selected
	button.visible = Selectable
	pass

func _on_button_pressed() -> void:
	On_Color_Selected.emit(Swatch_Color)
	Selected = true
	pass
