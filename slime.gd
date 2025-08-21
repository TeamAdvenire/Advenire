extends CharacterBody2D

@onready var animator: AnimatedSprite2D = $Animator
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $Animator/AudioStreamPlayer2D

var movementEnabled = true

var has_to_die = false

func _on_enemie_defeated() -> void:
	movementEnabled = false
	#audio_stream_player_2d.play()r
	animator.play("slime_death")
	has_to_die = true
	pass # Replace with function body.


func _on_enemie_hurt(ammount: Variant) -> void:
	movementEnabled = false
	animator.play("slime_hurt")
	pass # Replace with function body.


func _on_animation_finished() -> void:
	if (animator.animation.contains("hurt")):
		movementEnabled = true
	if(animator.animation.contains("death") || has_to_die):
		queue_free()
		var spriteFrames: SpriteFrames = animator.get_sprite_frames()
		var currentTexture: Texture2D = spriteFrames.get_frame_texture("slime_forward", 0)
		GlobalInventory.addXP(5, currentTexture)

# MARK: Pathfinding section!

var speed = 30

func _ready():
	nav_agent.path_desired_distance = 4.0
	nav_agent.target_desired_distance = 4.0
	call_deferred("actor_setup")
	if !SignalBus.is_connected("pause", pause):
		SignalBus.pause.connect(pause) 
	

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame


func _physics_process(delta):
	if wasSpotted:
		nav_agent.target_position = player.global_position
	if !movementEnabled:
		return
	if nav_agent.is_navigation_finished():
		# TODO: when the tracking is done, maybe try attacks later?
		animator.play("slime_forward")
		return
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav_agent.get_next_path_position()
	## FIXME: not really working right now, but idk..
	if next_path_position.y -position.y> 0 and !(next_path_position.x -position.x> 0 or next_path_position.x -position.x< 0): # move up
		animator.play("slime_forward")
	elif next_path_position.y -position.y< 0 and !(next_path_position.x -position.x> 0 or next_path_position.x -position.x< 0): # move down
		animator.play("slime_back")
	if  next_path_position.x -position.x < 0: # right
		animator.play("slime_left")
	elif next_path_position.x -position.x > 0: # left
		animator.play("slime_right")
		
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()

var wasSpotted := false
var player: Node2D


func was_player_spotted(boola: bool, body: Node2D) -> void:
	wasSpotted = boola
	if boola:
		player = body
		nav_agent.target_position = body.global_position
	else:
		nav_agent.target_position = nav_agent.target_position

func pause(value) -> void:
	movementEnabled = !value
	if(value):
		animator.pause()
	else:
		animator.play()
