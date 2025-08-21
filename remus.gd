extends AnimatedSprite2D

func _on_interactable_is_interacted_with() -> void:
	SignalBus.showDialogue.emit("hello", "this is some text", callbackable)
	GlobalInventory.addXP(1,Texture.new())

func callbackable():
	print("callbacking")
