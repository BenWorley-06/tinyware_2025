extends Enemy_State
class_name Patrolling

var patrol_offset:float=0
var direction:int

func enter():
	direction=[-1,1].pick_random()
func exit():pass
func update(delta:float):
	if enemy.path_node:
		patrol_offset += enemy.stats.patrol_speed*delta*direction
		var length = enemy.path_node.curve.get_baked_length()

		# Wrap patrol offset within valid range
		patrol_offset = fposmod(patrol_offset, length)

		var local_pos = enemy.path_node.curve.sample_baked(patrol_offset)
		enemy.global_position = enemy.path_node.to_global(local_pos)
		
func should_transition() -> Enemy_State:
	if get_dist_player()<=enemy.stats.detect_range and check_hidden()==false:
		if enemy.stats.through_walls_enable:
			return Chase_Pass_Through.new(enemy)
		return Chase_State_Nav.new(enemy)
	return null
