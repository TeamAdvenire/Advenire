extends TextureRect
class_name ItemSlot



var item: Item
@onready var itemInside: TextureRect = $Item
@onready var numberOfItem: RichTextLabel = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setItem(item: Item, number: int):
	self.item = item
	itemInside.texture = item.icon
	if number > 0:
		numberOfItem.text = str(number) 
	else: 
		numberOfItem.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	self_modulate.b += 30
	GlobalInventory.itemHovered.emit(item)


func _on_mouse_exited() -> void:
	self_modulate.b -= 30
