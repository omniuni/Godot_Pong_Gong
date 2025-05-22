@tool
class_name UiColorList
extends HBoxContainer

var has_selected: bool = false

@export var Swatch_Colors: Array[Color]:
	set(value):
		Swatch_Colors = value
		has_selected = false
		_ready()
		pass
		
@export var Selected_Color: Color = Color(0,0,0):
	set(value):
		Selected_Color = value
		has_selected = true
		_ready()
		pass
		
signal On_Color_Selected(color: Color)
		
func _ready() -> void:
	if not has_selected:
		Selected_Color = Swatch_Colors[0]
		# Setting the selected color will call _ready() again
		pass
	for child in get_children():
		child.queue_free()
	for color in Swatch_Colors:
		var new_swatch: UiColorSquare = preload("res://Scenes/item_color_square.tscn").instantiate()
		new_swatch.Swatch_Color = color
		if Selected_Color == color:
			new_swatch.Selected = true
		new_swatch.Selectable = true
		new_swatch.connect("On_Color_Selected", _on_color_selected)
		add_child(new_swatch)
	pass
	
func _on_color_selected(color: Color):
	Selected_Color = color
	On_Color_Selected.emit(Selected_Color)
	pass
