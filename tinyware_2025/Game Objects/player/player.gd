extends CharacterBody2D
class_name Player

@export var stats: Player_Stats

var in_Dir = Vector2.ZERO

func _process(delta: float) -> void:
	take_input()
	movement(delta)
	handle_visuals()
	move_and_slide()

func movement(delta:float) -> void:
	if in_Dir==Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO,stats.acceleration*delta)
	else:
		velocity = velocity.move_toward(in_Dir*stats.max_speed,stats.acceleration*delta)
		
func handle_visuals():
	if in_Dir!=Vector2.ZERO:
		look_at(global_position+in_Dir)


func take_input():
	in_Dir=Input.get_vector("left","right","up","down").normalized()
