extends Enemy_State
class_name Jump_Scare_State

func enter():
	enemy.velocity = Vector2.ZERO
	enemy.target.create_jump_scare_scene(enemy.stats.jump_scare_scene)
	
func exit():pass
func update(delta:float):pass
func should_transition() -> Enemy_State:
	return null
