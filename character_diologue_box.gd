extends Node2D

@onready var icon: TextureRect = $Icon
@onready var title: RichTextLabel = $Title
@onready var text: RichTextLabel = $Text


func _ready() -> void:
	if !SignalBus.is_connected("showDialogue", showDialogue):
		SignalBus.showDialogue.connect(showDialogue)


var pressedYet = false
func _input(event: InputEvent) -> void: 
	if event.is_pressed() && visible:
		if pressedYet:
			print("pressed within the event system")
			visible = false
			SignalBus.pause.emit(false)
			pressedYet = false
			callBack.call()
		else:
			pressedYet = true

var callBack: Callable
func showDialogue(name: String, textToShow: String, callback: Callable):
	self.callBack = callback
	SignalBus.pause.emit(true)
	visible = true
	title.text = name
	text.text = textToShow
