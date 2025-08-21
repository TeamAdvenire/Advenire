extends GridContainer

var resource = preload("res://assets/UI/item_pickup_text.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GlobalInventory.is_connected("itemAdded", onItemAdded):
		GlobalInventory.itemAdded.connect(onItemAdded)
	if !GlobalInventory.is_connected("xpAdded", onXpAdded):
		GlobalInventory.xpAdded.connect(onXpAdded)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onItemAdded(item: Item) -> void:
	for child in get_children():
		if child.has_method("setItem"):
			if child.item.isEquel(item):
				child.setItem(item, child.number + 1)
				return
	var new = resource.instantiate()
	add_child(new)
	new.setItem(item, 1)
	
func onXpAdded(xp: float, texture: Texture) -> void:
	var new = resource.instantiate()
	add_child(new)
	new.setOther("			+ " + str(xp) + " XP",texture)
