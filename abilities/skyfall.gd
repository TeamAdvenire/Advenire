extends Node2D

@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
var timer := Timer.new()
var inside = []

var disabled := false
var isUsing := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d_2.connect("frame_changed", _on_frame_changed)
	if !SignalBus.is_connected("pause", pause):
		SignalBus.pause.connect(pause)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !disabled and !isUsing:
		if Input.is_action_pressed("Sword_ability"):
			position = get_global_mouse_position()
			animated_sprite_2d_2.play("dote")
		elif Input.is_action_just_released("Sword_ability"):
			if SignalBus.checkUseMana(20):
				animated_sprite_2d_2.play("Skyfall")
				isUsing = true
			else:
				setEmpty()

# Frame changed callback
func _on_frame_changed():
	if animated_sprite_2d_2.frame == 10:
		for area in inside:
			area.doDamage(30)
			inside.erase(area)
	if animated_sprite_2d_2.frame == 20:
		isUsing = false
		setEmpty()

# Triggered when an area enters this node's area.
func _on_area_entered(area: Area2D) -> void:
	if area.has_method("doDamage"):
		inside.append(area)

# Triggered when an area exits this node's area.
func _on_area_2d_area_exited(area: Area2D) -> void:
	for areaa in inside:
		if areaa == area:
			inside.erase(areaa)

# Pause function to disable/enable ability usage
func pause(asdf) -> void:
	disabled = asdf
	if disabled:
		setEmpty()

# Function to reset the animation to a neutral state
func setEmpty():
	queue_free()
