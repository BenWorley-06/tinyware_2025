extends Enemy_State
class_name Melee_State

var attack_timer:float = 0.0

func enter():
	attack_timer=enemy.stats.melee_windup
func exit():pass
func update(delta:float):
	attack_timer-=delta

func should_transition() -> Enemy_State:
	if attack_timer<=0:
		hit_player()
		return Chase_State.new(enemy)
	if get_dist_player()>=enemy.stats.melee_range+20:
		return Chase_State.new(enemy)
	return null
	
func hit_player():
	enemy.target.take_damage(enemy.stats.melee_damage)
