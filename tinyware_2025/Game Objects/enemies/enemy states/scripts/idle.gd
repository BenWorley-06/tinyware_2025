extends Enemy_State
class_name Idle_State

func should_transition() -> Enemy_State:
	if enemy.stats.patrol_enable:
		return Patrolling.new(enemy)
	if get_dist_player()<=enemy.stats.detect_range:
		return Chase_State_Nav.new(enemy)
	return null
