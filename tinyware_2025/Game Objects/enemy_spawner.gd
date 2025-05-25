extends Node2D

@export var spawn_amount:int = 0
@export var spawn_wait:float = 100
@export var spawn_wait_start:float = 10

@onready var spawn_timer=spawn_wait_start

@onready var player = $/root/game/player

@export var barney_scene: PackedScene
@export var chup_scene: PackedScene
@export var gramp_scene: PackedScene

var paths: Array
var enemies: Array

func _ready() -> void:
	for child in $paths.get_children():
		if child is Path2D:
			paths.append(child)
	enemies=[barney_scene,chup_scene,gramp_scene]
	

func _process(delta: float) -> void:
	spawn_timer-=delta
	if spawn_timer<=0 and spawn_amount>0:
		spawn_amount-=1
		spawn_timer=spawn_wait
		spawn_enemy()
	
func spawn_enemy():
	var path_chosen = paths.pick_random()
	if paths.size() > 1:
		paths.erase(path_chosen)
	var best_point:= Vector2.ZERO
	var num_samples := 50
	
	var max_dist = 0
	
	var curve = path_chosen.curve
	for i in num_samples:
		var t := i / float(num_samples - 1)
		var pos = curve.sample_baked(t)
		var dist = player.global_position.distance_squared_to(pos)
		if dist > max_dist:
			max_dist = dist
			best_point = pos
		
	var enemy = enemies.pick_random().instantiate()
	enemy.global_position = best_point
	add_child(enemy)
	enemy.path_node=path_chosen
	print("spawned")
