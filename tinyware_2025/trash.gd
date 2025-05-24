extends Interactable

class_name Couch

signal hiding(player)

func interact(player: Node) -> void:
	print("Hidden")
	emit_signal("hiding", player)
