extends ColorRect



func _ready() -> void:
	if !SignalBus.is_connected("playerRespawn", onPlayerRespawn):
		SignalBus.playerRespawn.connect(onPlayerRespawn)
	if !SignalBus.is_connected("playerDied", onPlayerDied):
		SignalBus.playerDied.connect(onPlayerDied) 
	if !SignalBus.is_connected("openMagic", onOpenMagic):
		SignalBus.openMagic.connect(onOpenMagic) 
	
	
var isAllowedToOpen := true

func _input(event):
	if event.is_action_pressed("Exit") && isAllowedToOpen:
		visible = !visible
		SignalBus.pause.emit(visible)


func _on_inventory_pressed() -> void:
	SignalBus.openInventory.emit()
	SignalBus.pause.emit(true)
	visible = false


func _on_equipment_pressed() -> void:
	SignalBus.openEquipment.emit()
	SignalBus.pause.emit(true)
	visible = false

func onPlayerDied() -> void:
	isAllowedToOpen = false
	
func onPlayerRespawn() -> void:
	isAllowedToOpen = true

func onOpenMagic(truefalse: bool):
	isAllowedToOpen = !truefalse;


