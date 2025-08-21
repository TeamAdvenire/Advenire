extends Control

@onready var box: VBoxContainer = $TextureRect/VBoxContainer
@onready var title: TextureRect = $TextureRect/Title

var resource = preload("res://assets/UI/MagicScreenAssets/magic_row.tscn")


var chaosTitle = preload("res://assets/UI/MagicScreenAssets/ChaosTitle.tres")
var elementalTitle = preload("res://assets/UI/MagicScreenAssets/ElementalTitle.tres")
var coalesceTitle = preload("res://assets/UI/MagicScreenAssets/CoalesceTitle.tres")

var isPaused: bool = false

var indexSelected = 0;

var currentTypeSelected = Magic.magic_type.ELEMENTAL

var previouslySelected = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !SignalBus.is_connected("openMagic", onOpenMagic):
		SignalBus.openMagic.connect(onOpenMagic) 
	if !SignalBus.is_connected("pause", onIsPaused):
		SignalBus.pause.connect(onIsPaused) 
		

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if isPaused && !visible:
		return;

	if event.is_action_pressed("magic_screen"): 
		SignalBus.openMagic.emit(true)
	if event.is_action_released("magic_screen"):
		SignalBus.openMagic.emit(false)
	if visible:
		if event.is_action_pressed("attack"):
			selectedMagicCast();
			refreshInfo()
		if event.is_action_pressed("move_down"):
			setSelected(indexSelected + 1)
		if event.is_action_pressed("move_up"):
			setSelected(indexSelected - 1)
		if event.is_action_pressed("move_right"):
			setNextMagicCatagory()
		if event.is_action_pressed("move_left"):
			setPreviousMagicCatagory()	
		if event.is_action_pressed("space_bar"):
			selectedMagicCast()



func onOpenMagic(truefalse: bool) -> void:
	if isPaused && !visible:
		return;

	visible = truefalse
	SignalBus.pause.emit(visible);

	refreshInfo()
	
	setSelected(previouslySelected)


	
func refreshInfo():
	var children = box.get_children()

	for child in children:
		child.queue_free()

	if currentTypeSelected == Magic.magic_type.ELEMENTAL:
		title.texture = elementalTitle
	if currentTypeSelected == Magic.magic_type.CHAOS:
		title.texture = chaosTitle
	if currentTypeSelected == Magic.magic_type.COALESCENCE:
		title.texture = coalesceTitle

	var childrenSoFar = []

	for i in GlobalInventory.getMagics().size():
		if(GlobalInventory.getMagics()[i].type != currentTypeSelected):
			continue
		var newRow = resource.instantiate() 
		box.add_child(newRow)
		childrenSoFar.append(newRow)
		newRow.setMagic(GlobalInventory.getMagics()[i])

func setSelected(index: int):
	await SignalBus.waitForTime(0.01)
	indexSelected = index
	if(indexSelected > box.get_child_count() - 1):
		indexSelected = 0
	if(indexSelected < 0):
		indexSelected = box.get_child_count() - 1
	for i in box.get_child_count():
		var child = box.get_children()[i] 
		if(i == indexSelected):
			child.selectedImage.visible = true
		else: 
			child.selectedImage.visible = false
	previouslySelected = indexSelected
 
func onIsPaused(truefalse: bool) -> void:
	isPaused = truefalse

func setFromMagic(magic: Magic):
	for i in box.get_child_count():
		var child = box.get_child(i)
		if (child.magic == magic):
			setSelected(i)


func selectedMagicCast():
	if (box.get_child_count() <= 0):
		return
	var selectedMagic = box.get_child(indexSelected).magic as Magic
	visible = false
	SignalBus.startRadialMenu.emit(selectedMagic)

func setNextMagicCatagory():
	currentTypeSelected = wrapi(currentTypeSelected + 1, 0, 3) 
	refreshInfo()
	setSelected(0)

func setPreviousMagicCatagory():
	currentTypeSelected = wrapi(currentTypeSelected - 1, 0, 3) 
	refreshInfo()
	setSelected(0)
