extends Area2D
class_name Interactable

@onready var outline_material: ShaderMaterial = $Sprite2D.material

var can_interact = false

@export var stats: Interactable_Stats:
	set(value):
		stats = value
		if is_inside_tree() and value:
			update_collision()


func _ready():
	if stats:
		update_collision()
	set_outline(false)
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func set_outline(enabled: bool):
	outline_material.set_shader_parameter("outline_enabled", enabled)
	outline_material.set_shader_parameter("line_color", stats.outline_color)
	pass

func interact(player: Node) -> void:
	pass


func update_collision():
	var shape = $CollisionShape2D.shape
	print("Updated Collision")
	if shape is CircleShape2D:
		shape.radius = stats.interact_range
	else:
		print("Collision has to be circle")

func _on_body_entered(body):
	print("Can Interact")
	set_outline(true)
	can_interact = true
	body_entered_call()

func _on_body_exited(body):
	print("Can't Interact")
	set_outline(false)
	can_interact = false
	
func body_entered_call():
	pass
