extends Resource
class_name Ranged_Enemy_Stats

#	Timers
@export var fire_rate: float = 1
@export var fire_stagger: float = 1
var fire_timer: float = 0

@export var bullet_scene: PackedScene
