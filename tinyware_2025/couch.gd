extends Interactable

class_name Trash

signal hiding(player)

func interact(player: Node) -> void:
	print("Hidden")
	emit_signal("hiding", player)
