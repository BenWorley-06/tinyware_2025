extends CharacterBody2D
class_name Player

@export var stats: Player_Stats
var current_interactable: Interactable = null

var in_Dir = Vector2.ZERO

func _process(delta: float) -> void:
	sprite_toggle()
	take_input()
	movement(delta)
	handle_visuals()
	move_and_slide()
	interact_with()

func movement(delta:float) -> void:
	if not stats.can_move:
		velocity = Vector2.ZERO
	elif in_Dir==Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO,stats.acceleration*delta)
	else:
		velocity = velocity.move_toward(in_Dir*stats.max_speed,stats.acceleration*delta)
		
func handle_visuals():
	if in_Dir!=Vector2.ZERO:
		look_at(global_position+in_Dir)


func take_input():
	in_Dir=Input.get_vector("left","right","up","down").normalized()


func _on_area_2d_area_entered(area):
	if area is Interactable:
		current_interactable = area
		var callback = Callable(self, "_now_hiding")
		if not area.is_connected("hiding", callback):
			area.connect("hiding", callback)


func _on_area_2d_area_exited(area):
	if area == Interactable:
		current_interactable = null

func interact_with():
	if Input.is_action_just_pressed("interact"):
		if not stats.can_move and stats.awaiting_unpause:
				stats.can_move = true
				stats.awaiting_unpause = false
		elif current_interactable and current_interactable.can_interact:
				current_interactable.interact(self)

func _now_hiding(player):
	if player == self:
		print("Player now hidden!")
		stats.can_move = false
		stats.awaiting_unpause = true

func sprite_toggle():
	if stats.can_move:
		$Sprite2D.visible = true
	else:
		$Sprite2D.visible = false
