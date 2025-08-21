extends GridContainer

var slotarray: Array[TextureRect] = []

var currentItems: Array[Item] = []
# TODO: MAKE 32
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slotarray = [
		$ItemSlot, $ItemSlot2, $ItemSlot3, $ItemSlot4, $ItemSlot5, $ItemSlot6, $ItemSlot7, $ItemSlot8, $ItemSlot9, $ItemSlot10, $ItemSlot11, $ItemSlot12, $ItemSlot13, $ItemSlot14, $ItemSlot15, $ItemSlot16, $ItemSlot17, $ItemSlot18, $ItemSlot19, $ItemSlot20, $ItemSlot21, $ItemSlot22, $ItemSlot23, $ItemSlot24, $ItemSlot25, $ItemSlot26, $ItemSlot27, $ItemSlot28, $ItemSlot29, $ItemSlot31, $ItemSlot32
	]
	if !GlobalInventory.is_connected("itemAdded", update):
		GlobalInventory.itemAdded.connect(update)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update(item: Item):
	currentItems = GlobalInventory.items
	#currentItems.append(item)
	var itemsToUse = []
	var numbers = []
	for i in currentItems.size():
		#if itemsToUse.is_empty():
			#itemsToUse.append(currentItems[i])
			#numbers.append(1)
			#continue
		#if i > itemsToUse.size() - 1:
			#continue
		var notnew = -1
		for number in itemsToUse.size() :
			if itemsToUse[number].isEquel(currentItems[i]):
				notnew = number
				print(notnew)
		if notnew > -1:
			numbers[notnew] += 1
			print(numbers[notnew])
		else: 
			itemsToUse.append(currentItems[i])
			numbers.append(1)
		print(itemsToUse)
	
	
	for i in 31:
		var toUse = slotarray[i]
		if i > itemsToUse.size() -1:
			continue
		if toUse is ItemSlot:
			toUse.setItem(itemsToUse[i], numbers[i])
