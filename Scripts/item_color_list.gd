@tool
extends HBoxContainer

var swatches: Array[Color] = []
var has_selected: bool = false
var selected: Color = Color(0,0,0)

signal on_color_selected(color: Color)

@export var Swatch_Colors: Array[Color]:
	get:
		return swatches
		pass
	set(value):
		has_selected = true
		swatches = value
		_ready()
		pass
		
func add_color(new_color: Color):
	swatches.append(new_color)
	_ready()
	pass
	
func set_selected_color(color: Color):
	_on_color_selected(color)
	pass
		
func _ready() -> void:
	for child in get_children():
		child.queue_free()
	if not has_selected:
		selected = swatches[0]
	for color in swatches:
		var new_swatch = preload("res://Scenes/item_color_square.tscn").instantiate()
		new_swatch.set_swatch_color(color)
		if selected == color:
			new_swatch.set_color_selected(true)
		new_swatch.connect("on_color_selected", _on_color_selected)
		add_child(new_swatch)
	pass
	
func _on_color_selected(color: Color):
	selected = color
	_ready()
	on_color_selected.emit(selected)
	pass
