extends CharacterBody2D
class_name Enemy

@export var stats: Enemy_Stats

@onready var state: State_Manager = $state_manager
@onready var esprite: AnimatedSprite2D = $esprite
@onready var sfx: AudioStreamPlayer2D = $sfx
@onready var jingle_audio: AudioStreamPlayer = $jingle_audio

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var collider: CollisionShape2D = $CollisionShape2D

@onready var target: Player = $/root/game/player

var path_node: Path2D

var caught=false

func _ready() -> void:
	jingle_audio.stream = stats.jingle
	jingle_audio.play()
	sfx.stream=stats.walking
	sfx.play()

func _process(delta: float) -> void:
	state.update(delta)
	if stats.look_enable:
		look_at(target.global_position)
	catch_player()
	move_and_slide()
	queue_redraw()
	
func take_damage(amount:int):
	stats.hp-=amount
	if stats.hp<=0:
		dead()
		
func dead():
	queue_free()
	
func alert(noise_position: Vector2):
	if global_position.distance_to(noise_position)<=stats.hear_range:
		print("alerted")
		if stats.through_walls_enable:
			state.switch_to(Chase_Pass_Through.new(self))
		else:
			state.switch_to(Chase_State_Nav.new(self))
			
func catch_player():
	if !target.is_hidden and global_position.distance_to(target.global_position)<=stats.catch_range and !caught:
		print("BOO")
		state.switch_to(Jump_Scare_State.new(self))	
		caught=true
	
