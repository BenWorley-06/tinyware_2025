extends Enemy_State
class_name Circling_State

var clockwise = randi() % 2 == 0

func enter():pass
func exit():pass
func update(delta:float):
	enemy.velocity=circle_movement()

func should_transition() -> Enemy_State:
	if get_dist_player()<=enemy.stats.melee_range:
		return Melee_State.new(enemy)
	if get_dist_player()>=enemy.stats.circle_range+20:
		return Chase_State.new(enemy)
	return null

func circle_movement()->Vector2:
	var target_dir = (enemy.target.position-enemy.position).normalized()
	# Perpendicular vector (rotate 90 degrees)
	var circle_direction = Vector2(target_dir.y, -target_dir.x) if clockwise else Vector2(-target_dir.y, target_dir.x)
	var steer = (circle_direction*enemy.stats.speed)-enemy.velocity
	return enemy.velocity+(steer*enemy.stats.max_force)
