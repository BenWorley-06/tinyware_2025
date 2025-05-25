extends Interactable
class_name Sound_Maker



func body_entered_call():
	get_tree().call_group("enemies", "alert", global_position)
	print("calling")
