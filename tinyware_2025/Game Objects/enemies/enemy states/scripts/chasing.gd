extends Enemy_State
class_name Chase_State

var tree: SceneTree

var context_vectors = [
	Vector2.LEFT, 
	Vector2.RIGHT, 
	Vector2.UP, 
	Vector2.DOWN, 
	Vector2(-1, -1).normalized(), 
	Vector2(1, -1).normalized(), 
	Vector2(-1, 1).normalized(), 
	Vector2(1, 1).normalized()
]
var context_weights: Array = []


func enter():
	tree = enemy.get_tree()
	context_weights.resize(context_vectors.size())

func exit():
	enemy.velocity=Vector2.ZERO
	
func update(delta:float):
	enemy.velocity=steering()

func should_transition() -> Enemy_State:
	if get_dist_player()<=enemy.stats.melee_range:
		return Melee_State.new(enemy)
	elif get_dist_player()<=enemy.stats.circle_range and enemy.stats.enable_circle:
		return Circling_State.new(enemy)
	elif get_dist_player()<=enemy.stats.fire_range and enemy.stats.enable_fire:
		return Firing_State.new(enemy)
	return null
	
func steering()->Vector2:
	calc_weights()
	var desired_velocity = choose_dir()*enemy.stats.speed
	var steer = desired_velocity-enemy.velocity
	var target_velocity= enemy.velocity+(steer*enemy.stats.max_force)
	return target_velocity
	
func calc_weights():
	var avoid_dir = enemy_avoid()
	var target_dir=(enemy.target.position-enemy.position).normalized()
	for i in range(context_vectors.size()):
		var dot_prod = context_vectors[i].dot(target_dir)
		var avoid_weight = context_vectors[i].dot(avoid_dir)
		
		context_weights[i]= dot_prod - (avoid_weight)
		
func choose_dir():
	var max_weight=-1.0
	var best_dir = Vector2.ZERO
	for i in range(context_vectors.size()):
		if context_weights[i]>max_weight:
			max_weight=context_weights[i]
			best_dir=context_vectors[i]
	return best_dir
	
func enemy_avoid():
	var avoidance = Vector2.ZERO
	if tree == null:
		return avoidance  # Failsafe
	
	var enemies = tree.get_nodes_in_group("enemies")
	for body in enemies:
		if body!=enemy:
			var dist = enemy.position.distance_to(body.position)
			if dist < enemy.stats.avoid_range:
				var repulsion = (enemy.position-body.position).normalized()/dist
				var size_factor = max(body.scale.length(), 1.0) / max(enemy.scale.length(), 1.0)
				var strength: float = 0
				if enemy.stats.seperation>dist:
					strength=0.2
				else:
					strength = (enemy.stats.seperation - dist) * size_factor
				avoidance+=(repulsion*strength)
				
	return avoidance
