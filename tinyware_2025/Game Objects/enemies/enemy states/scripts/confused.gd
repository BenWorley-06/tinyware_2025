extends Enemy_State
class_name Confused

func enter():
	enemy.velocity=Vector2.ZERO
func exit():pass
func update(delta:float):pass
func should_transition() -> Enemy_State:
	if check_hidden():
		return null
	else:
		return Chase_State_Nav.new(enemy)  # override in subclasses
