extends Node
class_name State_Manager

@export var initial_state_scene: PackedScene

var current_state: Enemy_State = null

func _ready():
	current_state=Idle_State.new(get_parent())

func switch_to(new_state: Enemy_State):
	if current_state:
		current_state.exit()
	current_state=new_state
	current_state.enter()

func update(delta:float):
	if current_state:
		current_state.update(delta)
		var next = current_state.should_transition()
		if next:
			switch_to(next)
