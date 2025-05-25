extends Enemy_State
class_name Patrolling

var patrol_offset:float=0

func enter():pass
func exit():pass
func update(delta:float):
	if enemy.path_node:
		patrol_offset += enemy.stats.patrol_speed*delta
		var local_pos = enemy.path_node.curve.sample_baked(patrol_offset)
		enemy.global_position = enemy.path_node.to_global(local_pos)
		
func should_transition() -> Enemy_State:
	if get_dist_player()<=enemy.stats.detect_range:
		return Chase_State_Nav.new(enemy)
	return null
