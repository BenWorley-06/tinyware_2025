extends Enemy

var voice_lines:Array = [preload("res://Assets/sounds/dave/Dave1.wav"),preload("res://Assets/sounds/dave/Dave2.wav"),
preload("res://Assets/sounds/dave/Hiram Way 6 (mp3cut.net).wav"),preload("res://Assets/sounds/dave/Hiram Way 9 (mp3cut.net).wav"),
preload("res://Assets/sounds/dave/Hiram Way 20 (mp3cut.net).wav")]

@onready var voice: AudioStreamPlayer2D = $voice

var voice_wait_max: float = 5
var voice_wait_mix: float = 3
var voice_timer: float = 0
var talking = false

func always_called(delta):
	voice_timer-=delta
	if voice_timer<=0:
		voice_timer=randf_range(voice_wait_mix,voice_wait_max)
		if talking:
			talking = false
		else:
			talking = true
			voice.stream = voice_lines.pick_random()
			voice.play()
		
