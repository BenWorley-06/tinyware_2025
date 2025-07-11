extends Enemy_State
class_name Confused

var end_timer:float = 4

func enter():
	enemy.velocity=Vector2.ZERO
	enemy.esprite.speed_scale=0
func exit():pass
func update(delta:float):
	end_timer-=delta
func should_transition() -> Enemy_State:
	if check_hidden():
		if end_timer<=0:
			return Retreat.new(enemy)
		return null
	else:
		return Chase_State_Nav.new(enemy)  # override in subclasses
