extends Resource
class_name Enemy_Stats

#	Movement
@export var speed: float = 200
@export var max_force: float = 0.5

@export var patrol_speed: float = 200
@export var patrol_offset:float = 0

#	Timers
@export var path_calc_time:float = 0.2

#	Ranges
@export var detect_range:float = 400
@export var catch_range: float = 70

#	Enablers
@export var patrol_enable: int =1
@export var through_walls_enable:int = 1
