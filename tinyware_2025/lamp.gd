extends Interactable
@onready var lighting: Node2D = $lighting  # the parent node of multiple Light2D children
@onready var sfx: AudioStreamPlayer2D = $sfx

var lamp_on = false
var fade_in_speed = 1.0
var fade_out_speed = 0.3
var flicker_duration = 4.0
var dimming_duration = 4.0
var timer = 0.0

var break_chance:float = 0.3

var broken = false

func _ready():
	for child in lighting.get_children():
		if child is Light2D:
			child.visible = false
			child.energy = 0.0

func interact(player: Node):
	if lamp_on: return
	if broken:return
	if randf() < break_chance:
		break_lamp()
		return
	lamp_on = true
	timer = 0.0
	for child in lighting.get_children():
		if child is Light2D:
			child.visible = true

func _process(delta: float) -> void:
	if lamp_on:
		timer += delta

		if timer < flicker_duration:
			for child in lighting.get_children():
				if child is Light2D:
					var target = lerp(child.energy, 1.0, delta * fade_in_speed)
					child.energy = target * randf_range(0.9, 1.1)

		elif timer < flicker_duration + dimming_duration:
			var t = (timer - flicker_duration) / dimming_duration
			var target_energy = lerp(1.0, 0.0, t)
			for child in lighting.get_children():
				if child is Light2D:
					child.energy = target_energy * randf_range(0.8, 1.2)

		else:
			for child in lighting.get_children():
				if child is Light2D:
					child.energy = 0.0
					child.visible = false
			lamp_on = false
			
func break_lamp():
	get_tree().call_group("enemies", "alert", global_position)
	print("calling")
	broken=true
	sfx.play()
