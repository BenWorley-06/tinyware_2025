extends Node


var title_scene = preload("res://Assets/Menu/Scenes/start_menu.tscn")
var game_scene = preload("res://Game Objects/game.tscn")
var game_over_scene = preload("res://Assets/Menu/Scenes/end_menu.tscn")
var death_scene = preload("res://Assets/Menu/Scenes/death_screen.tscn")

func go_to_title():
	get_tree().change_scene_to_packed(title_scene)

func go_to_game():
	get_tree().change_scene_to_packed(game_scene)

func go_to_game_over():
	get_tree().change_scene_to_packed(game_over_scene)

func go_to_death_screen():
	get_tree().change_scene_to_packed(death_scene)
