extends Interactable
class_name Sound_Maker

@onready var sfx: AudioStreamPlayer2D = $sfx

var done=false

func body_entered_call(body):
	if body.is_in_group("player") and !done:
		get_tree().call_group("enemies", "alert", global_position)
		print("calling")
		done=true
		sfx.play()
