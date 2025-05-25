extends Enemy_State
class_name Chase_State_Nav

var path_timer:float = 0

var tree: SceneTree

func enter():
	tree = enemy.get_tree()
	
func exit():
	enemy.velocity=Vector2.ZERO
	
func update(delta:float):
	path_timer-=delta
	if path_timer<=0:
		enemy.nav.target_position=enemy.target.global_position
		path_timer = enemy.stats.path_calc_time
	steering(delta)

func should_transition() -> Enemy_State:
	if check_hidden():
		return Confused.new(enemy)
	return null

func steering(delta:float):
	var direction = enemy.nav.get_next_path_position()-enemy.global_position
	direction = direction.normalized()
	var desired_velocity = direction*enemy.stats.speed
	var steer = desired_velocity-enemy.velocity
	enemy.velocity += (steer*enemy.stats.max_force)
	
