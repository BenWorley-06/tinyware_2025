extends Enemy_State
class_name Chase_Pass_Through

func enter():
	enemy.collider.disabled=true
	enemy.esprite.speed_scale=1
func exit():pass
func update(delta:float):
	steering(delta)
func should_transition() -> Enemy_State:
	if check_hidden():
		return Confused.new(enemy)
	return null
	
func steering(delta:float):
	var direction = enemy.target.global_position-enemy.global_position
	direction = direction.normalized()
	var desired_velocity = direction*enemy.stats.speed
	var steer = desired_velocity-enemy.velocity
	enemy.velocity += (steer*enemy.stats.max_force)
