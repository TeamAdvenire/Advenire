extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !SignalBus.is_connected("playerDied", onPlayerDied):
		SignalBus.playerDied.connect(onPlayerDied)

func onPlayerDied():
	visible = true
	



func _on_button_pressed() -> void:
	SignalBus.playerRespawn.emit()
	visible = false
