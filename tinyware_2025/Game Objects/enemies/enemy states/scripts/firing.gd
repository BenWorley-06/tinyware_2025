extends Enemy_State
class_name Firing_State

var cancel=false

func enter():
	enemy.range_stats.fire_timer=enemy.range_stats.fire_stagger
	fire()
func exit():
	enemy.range_stats.fire_timer=enemy.range_stats.fire_rate
func update(delta:float):pass
func should_transition() -> Enemy_State:
	if enemy.range_stats.fire_timer<=0:
		return Chase_State.new(enemy)
	if get_dist_player() >= enemy.stats.fire_range +30:
		return Chase_State.new(enemy)
	return null

func fire():
	var direction = (enemy.target.position-enemy.position).normalized()
	var bullet = enemy.range_stats.bullet_scene.instantiate()
	bullet.global_position = enemy.global_position
	enemy.get_tree().current_scene.add_child(bullet)
	bullet.fire(direction)
