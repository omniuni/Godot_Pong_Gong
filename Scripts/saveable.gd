class_name SaveableNode
extends Node

var _Enable_Saving: bool = false:
	set(value):
		if self.name.is_empty():
			_Enable_Saving = false
			return
		_Enable_Saving = value
		if value:
			print("Saving enabled for `"+self.name+"`")
		else:
			print("Saving disabled for `"+self.name+"`")
		pass
		
var supported_types = [
	Variant.Type.TYPE_BOOL,
	Variant.Type.TYPE_INT,
	Variant.Type.TYPE_FLOAT,
	Variant.Type.TYPE_STRING,
	Variant.Type.TYPE_COLOR
]

func _init():
	#check if this has been saved before
	
	#if saved, load the save, and set the properties
	
	#enable saving
	_Enable_Saving = true
	
	pass
	
func _save() -> void:
	if not _Enable_Saving: return
	var saveable_class: String = self.name 
	print_debug("_save() called from "+saveable_class)
	
	var saveable_properties: Array = Array()
	for property in get_property_list():
		var propertyName: String = property["name"]
		if propertyName.begins_with("_"): continue
		var propertyUsage = property["usage"]
		var propertyType = property["type"]
		if propertyUsage == PROPERTY_USAGE_SCRIPT_VARIABLE and supported_types.has(propertyType):
			var saveable_property: Dictionary = Dictionary()
			saveable_property.set("name", propertyName)
			saveable_property.set("type", propertyType)
			saveable_property.set("value", get(propertyName))
			saveable_properties.append(saveable_property)
		pass
		
	var saveable_json = JSON.stringify(saveable_properties, "\t")
	#print("Preparing to save: "+saveable_json)
	
	DirAccess.make_dir_recursive_absolute("user://saves/0000")
	var save_file: FileAccess = FileAccess.open("user://saves/0000/"+saveable_class+".save.json", FileAccess.WRITE)
	if save_file == null:
		push_error("Unable to save file: %s" % error_string(FileAccess.get_open_error()))
		return
	save_file.store_line(saveable_json)
	print("Saved "+str(saveable_properties.size())+" values to "+OS.get_user_data_dir()+save_file.get_path().replace("user:/","")+".")
	
	pass

func _load() -> void:
	
	pass
