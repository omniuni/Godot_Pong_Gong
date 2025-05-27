class_name SaveableNode
extends Node

func _ready() -> void:
	_load()
	_Enable_Saving = true
	pass

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
		
var _config = ConfigFile.new()
	
func _get_save_directory() -> String:
	return "saves/0000"

func _get_save_file_path() -> String:
	return _get_save_directory()+"/"+self.name+"_save.config"
	
func _save() -> void:
	if not _Enable_Saving: return
	for property in get_property_list():
		var propertyName: String = property["name"]
		if propertyName.begins_with("_"): continue
		var propertyUsage = property["usage"]
		if propertyUsage == PROPERTY_USAGE_SCRIPT_VARIABLE:
			_config.set_value(self.name, propertyName, get(propertyName))
		pass
	DirAccess.make_dir_recursive_absolute("user://"+_get_save_directory())
	_config.save("user://"+_get_save_file_path())
	print_debug("Saved config to "+OS.get_user_data_dir()+"/"+_get_save_file_path())
	pass

func _load() -> void:
	_config.load("user://"+_get_save_file_path())
	for property in get_property_list():
		var propertyName: String = property["name"]
		if propertyName.begins_with("_"): continue
		var propertyUsage = property["usage"]
		if propertyUsage == PROPERTY_USAGE_SCRIPT_VARIABLE:
			var value = _config.get_value(self.name, propertyName, get(propertyName))
			if value != null:
				set(propertyName, value)
		pass
	print_debug("Successfully loaded config.")
	pass
