extends Control

@onready var sprite_list = [
	$EyesInTheDark,
	$EyesInTheDark2,
	$EyesInTheDark3,
	$EyesInTheDark4,
	$EyesInTheDark5,
	$EyesInTheDark6,
	$EyesInTheDark7,
	$EyesInTheDark8,
	$EyesInTheDark9
]

func _on_play_pressed():
	$PlaySound.play()
	$PlaySound.finished
	await start_transition()
	SceneManager.go_to_game()


func _on_exit_pressed():
	get_tree().quit()


func start_transition():
	for sprite in sprite_list:
		sprite.visible = true
		await get_tree().create_timer(0.1).timeout
	await get_tree().create_timer(1.0).timeout
