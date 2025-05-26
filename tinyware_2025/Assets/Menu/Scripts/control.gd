extends Control

func _process(delta):
	finish_cutscene()

func finish_cutscene():
	if Input.is_action_just_pressed("space"):
		SceneManager.go_to_game()
