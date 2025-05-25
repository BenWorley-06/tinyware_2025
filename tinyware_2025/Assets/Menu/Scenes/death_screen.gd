extends Control


func _process(delta):
	$AnimatedSprite2D.play()

func _on_retry_pressed():
	SceneManager.go_to_game()


func _on_main_pressed():
	SceneManager.go_to_title()
