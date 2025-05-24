extends Node
class_name Enemy_State

var enemy: CharacterBody2D

func _init(_parent: CharacterBody2D) -> void:
	enemy = _parent

func enter():pass
func exit():pass
func update(delta:float):pass
func should_transition() -> Enemy_State:
	return null  # override in subclasses

func get_dist_player():
	return enemy.global_position.distance_to(enemy.target.global_position)
