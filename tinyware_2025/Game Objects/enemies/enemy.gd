extends CharacterBody2D
class_name Enemy

@export var stats: Enemy_Stats

@onready var state: State_Manager = $state_manager
@onready var sprite: Sprite2D = $Sprite2D

@onready var target: player = $/root/game/player

func _process(delta: float) -> void:
	state.update(delta)
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
	move_and_slide()
	
func take_damage(amount:int):
	stats.hp-=amount
	if stats.hp<=0:
		dead()
		
func dead():
	queue_free()
