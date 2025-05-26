extends CharacterBody2D
class_name Player

@export var stats: Player_Stats

@onready var psprite: AnimatedSprite2D = $psprite
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var camera: Camera2D = $Camera2D
@onready var walk: AudioStreamPlayer = $walk
@onready var cooing: AudioStreamPlayer = $cooing

var current_interactable: Interactable = null

var is_hidden = false

var in_Dir = Vector2.ZERO

var tutorial_timer:float = 5
var tutorial_on=true

func _ready() -> void:
	walk.play()
	
func _process(delta: float) -> void:
	
	if tutorial_on:
		tutorial_timer-=delta
		if tutorial_timer<=0:
			tutorial_on=false
			$gui.queue_free()
		
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
		psprite.speed_scale=1
		walk.stream_paused=false
	else:
		psprite.speed_scale=0
		walk.stream_paused=true
	sprite_toggle()


func take_input():
	in_Dir=Input.get_vector("left","right","up","down").normalized()


func _on_area_2d_area_entered(area):
	if area is Interactable:
		current_interactable = area
		var callback1 = Callable(self, "_now_hiding")
		var callback2 = Callable(self, "_now_trap")
		if not area.is_connected("hiding", callback1):
			area.connect("hiding", callback1)
		if not area.is_connected("chance", callback2):
			area.connect("chance", callback2)


func _on_area_2d_area_exited(area):
	if area == Interactable:
		current_interactable = null

func interact_with():
	if Input.is_action_just_pressed("interact"):
		if not stats.can_move and stats.awaiting_unpause:
				stats.can_move = true
				stats.awaiting_unpause = false
				is_hidden=false
				collider.disabled=false
		elif current_interactable and current_interactable.can_interact:
				current_interactable.interact(self)

func _now_hiding(player):
	if player == self:
		print("Player now hidden!")
		is_hidden=true
		stats.can_move = false
		stats.awaiting_unpause = true
		collider.disabled=true

func _now_trap(player):
	if player == self:
		var random_number = randi() % 10 + 1
		if random_number <= 3:
			print("Player now Frozen")
			stats.frozen = true
			stats.can_move = false
			stats.awaiting_unpause = true
			await get_tree().create_timer(5.0).timeout
			print("Player unfrozen")
			stats.frozen = false
			stats.can_move = true
			stats.awaiting_unpause = false
		else:
			print("Player saved!")
			var texture_size = $PointLight2D2.texture
			is_hidden = true
			texture_size.width = 1000
			texture_size.height = 1000
			await get_tree().create_timer(5.0).timeout
			print("Player not saved :(")
			is_hidden = false
			texture_size.width = 500
			texture_size.height = 500

func sprite_toggle():
	if stats.can_move:
		psprite.visible = true
		$PointLight2D.visible=false
	elif not stats.can_move and not stats.frozen:
		psprite.visible = false
		$PointLight2D.visible=false
		
func create_jump_scare_scene(scene: PackedScene):
	var scare = scene.instantiate()
	$/root/game.add_child(scare)
	
