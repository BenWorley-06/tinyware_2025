extends Resource
class_name Enemy_Stats

#	Movement
@export var speed: float = 200
@export var max_force: float = 0.5


#	Health
@export var hp_max:int = 50
var hp = hp_max

#	Damage
@export var melee_damage: int = 10

#	Enablers
@export_range(0,1) var enable_circle: int = 1
@export_range(0,1) var enable_fire: int = 0

#	Timers
@export var melee_windup:float = 0.4

#	Ranges
@export var melee_range: float = 70
@export var chase_range: float = 1000

@export var circle_range: float = 80
@export var fire_range: float = 100

@export var avoid_range:float = 500
@export var seperation:float = 100
