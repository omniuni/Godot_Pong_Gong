extends Node

var menu = preload("res://Scenes/menu_main.tscn")
var app = preload("res://Scenes/app_main.tscn")
var settings = preload("res://Scenes/app_settings.tscn")
var help = preload("res://Scenes/app_help.tscn")

func change_to(tree: SceneTree, target: Resource):
	var currentScene = tree.current_scene
	var targetScene = target.instantiate()
	Beeper.play_ui()
	tree.root.add_child(targetScene)
	tree.root.remove_child(currentScene)
	tree.set_current_scene(targetScene)
	pass
