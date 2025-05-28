extends Control

func _ready():
	$AudioStreamPlayer.play(1.0)
	await get_tree().create_timer(6.0).timeout
	$AudioStreamPlayer.stop()

func _on_retry_pressed():
	SceneManager.go_to_game()


func _on_main_pressed():
	SceneManager.go_to_title()
