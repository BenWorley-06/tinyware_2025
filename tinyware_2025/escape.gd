extends Interactable

class_name Escape
func interact(player: Node):
	print("Escaped!")
	SceneManager.go_to_game_over()
