extends Enemy_State
class_name Retreat

var end_timer:float = 2

func enter():
	var direction=(enemy.target.global_position-enemy.global_position).normalized()
	enemy.velocity = -direction*enemy.stats.speed
	enemy.esprite.speed_scale=1
func exit():pass
func update(delta:float):
	end_timer-=delta
func should_transition() -> Enemy_State:
	if check_hidden():
		if end_timer<=0:
			return Patrolling.new(enemy)
		return null
	else:
		return Chase_State_Nav.new(enemy)  # override in subclasses
