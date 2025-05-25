extends CanvasLayer
class_name jump_scare

@onready var sprite_2d: Sprite2D = $Sprite2D

var end_timer:float = 2.0

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	sprite_2d.centered = true
	sprite_2d.position = screen_size / 2

	var texture_size = sprite_2d.texture.get_size()
	sprite_2d.scale = screen_size / texture_size

func _process(delta: float) -> void:
	end_timer -= delta
	if end_timer <= 0:
		SceneManager.go_to_game_over()
