@tool
extends PanelContainer

var swatch = Color(0,0,0)
var selected = false

signal on_color_selected(color: Color)

@export var Swatch_Color: Color:
	get:
		return swatch
	set(value):
		swatch = value
		_ready()
		
func set_swatch_color(color: Color):
	Swatch_Color = color
	pass
	
func set_color_selected(is_selected: bool):
	selected = is_selected
	_ready()
	pass

func _ready() -> void:
	$MarginContainer/ColorRect.color = Swatch_Color
	$MarginContainer/P2D1.visible = selected
	$MarginContainer/P2D2.visible = selected

func _on_button_pressed() -> void:
	on_color_selected.emit(swatch)
	pass
