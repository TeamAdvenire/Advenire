extends Node2D
class_name Interactable

@export var interactTitle = "Interact"

@onready var rich_text_label: RichTextLabel = $RichTextLabel


signal isInteractedWith()

var playerInsideArea := false

var isPaused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rich_text_label.text = "[center]" + interactTitle + " [f]"
	rich_text_label.modulate = Color(0,0,0,0)
	if !SignalBus.is_connected("pause", pause):
		SignalBus.pause.connect(pause)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && playerInsideArea && !isPaused:
		isInteractedWith.emit()

func pause(isPaused: bool) -> void:
	self.isPaused = isPaused

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.has_method("playerDeath")):
		playerInsideArea = true
		var tween = get_tree().create_tween()
		tween.tween_property(rich_text_label, "modulate", Color.WHITE, 0.3)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.has_method("playerDeath")):
		playerInsideArea = false
		var tween = get_tree().create_tween()
		tween.tween_property(rich_text_label, "modulate", Color(0,0,0,0), 0.3)
