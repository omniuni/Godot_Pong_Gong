extends Node

## This is a helper script for scene navigation.
## It efficiently preloads, laods, and navigates between scenes.

var menu = load("res://Scenes/screen_menu.tscn")
var app = load("res://Scenes/screen_main.tscn")
var settings = load("res://Scenes/screen_settings.tscn")
var help = load("res://Scenes/screen_help.tscn")
var bindings = load("res://Scenes/screen_bindings.tscn")

func change_to(tree: SceneTree, target: Resource):
	var currentScene = tree.current_scene
	var targetScene = target.instantiate()
	tree.root.add_child(targetScene)
	tree.root.remove_child(currentScene)
	tree.set_current_scene(targetScene)
	pass

func quit(tree: SceneTree):
	tree.quit()
	pass
