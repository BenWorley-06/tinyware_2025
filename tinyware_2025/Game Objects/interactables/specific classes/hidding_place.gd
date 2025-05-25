extends Interactable
class_name Hidding_Place

signal hiding(player)

func interact(player: Node) -> void:
	print("Hidden")
	emit_signal("hiding", player)
