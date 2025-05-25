extends CanvasLayer
class_name jump_scare

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var black_fade: ColorRect = $BlackFade

# Images
@export var jsp1: CompressedTexture2D
@export var jsp2: CompressedTexture2D

# Settings
var end_timer: float = 2.0
var shake_intensity: float = 10.0
var original_position: Vector2

func _ready():
	# Pick random texture
	sprite_2d.texture = [jsp1, jsp2].filter(func(t): return t != null).pick_random()
	
	# Setup screen center and scale
	var screen_size = get_viewport().get_visible_rect().size
	sprite_2d.centered = true
	sprite_2d.position = screen_size / 2

	var screen_ratio = screen_size.x / screen_size.y
	var texture_size = Vector2(sprite_2d.texture.get_width(), sprite_2d.texture.get_height())
	var texture_ratio = texture_size.x / texture_size.y

	if screen_ratio > texture_ratio:
		sprite_2d.scale = Vector2.ONE * (screen_size.y / texture_size.y)
	else:
		sprite_2d.scale = Vector2.ONE * (screen_size.x / texture_size.x)

	original_position = sprite_2d.position

	# Start black fade invisible
	black_fade.color.a = 0.0

func _process(delta: float) -> void:
	end_timer -= delta

	if end_timer > 0:
		# Screen shake
		var offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
		sprite_2d.position = original_position + offset

		# Fade in black overlay
		var alpha = clamp(1.0 - (end_timer / 2.0), 0.0, 1.0)
		var fade_color = black_fade.color
		fade_color.a = alpha
		black_fade.color = fade_color
	else:
		SceneManager.go_to_game_over()
