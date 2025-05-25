extends Node2D

@export_range(0,1) var spawn_chance: float = 1
@export var object_scene: PackedScene

func _ready() -> void:
	var odds=randf_range(0,1)
	print(odds)
	print(odds<=spawn_chance)
	if odds<=spawn_chance:
		print("done")
		var object = object_scene.instantiate()
		add_child(object)
		print("Object Spawned")
		
