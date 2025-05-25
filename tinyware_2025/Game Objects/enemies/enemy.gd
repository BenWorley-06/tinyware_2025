extends CharacterBody2D
class_name Enemy

@export var stats: Enemy_Stats

@onready var state: State_Manager = $state_manager
@onready var esprite: AnimatedSprite2D = $esprite

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var collider: CollisionShape2D = $CollisionShape2D

@onready var target: Player = $/root/game/player

var path_node: Path2D

func _process(delta: float) -> void:
	state.update(delta)
	look_at(target.global_position)
	move_and_slide()
	queue_redraw()
	
func take_damage(amount:int):
	stats.hp-=amount
	if stats.hp<=0:
		dead()
		
func dead():
	queue_free()
	
