extends Control

func _on_play_pressed():
	SceneManager.go_to_game()


func _on_exit_pressed():
	get_tree().quit()
