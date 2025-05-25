extends Interactable

class_name Trap

signal chance(player)

func interact(player: Node) -> void:
	print("Chance")
	emit_signal("chance", player)
