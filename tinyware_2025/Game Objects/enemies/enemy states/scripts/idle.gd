extends Enemy_State
class_name Idle_State

func should_transition() -> Enemy_State:
	if get_dist_player()<=enemy.stats.chase_range:
		return Chase_State.new(enemy)
	return null
