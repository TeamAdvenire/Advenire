extends ColorRect

var item: Item

@onready var title: RichTextLabel = $Title
@onready var equipped_: RichTextLabel = $"Title/Equipped?"
@onready var texture: TextureRect = $Title/Texture

var wasEquipped = false

signal hovered(Item)

func _ready() -> void:
	if !GlobalInventory.is_connected("weaponChanged", weaponChanged):
		GlobalInventory.weaponChanged.connect(weaponChanged)

func setItem(item: Item) -> void:
	self.item = item
	title.text = "[center]" + item.title
	texture.texture = item.icon
	weaponChanged(item)



func _on_mouse_entered() -> void:
	#pass
	color.a +=0.3
	hovered.emit(item)
	equipped_.visible = true

func _on_mouse_exited() -> void:
	#pass
	color.a -= 0.3
	if(!wasEquipped):
		equipped_.visible = false
	
func weaponChanged(newItem: Weapon):
	if item.isEquel(GlobalInventory.getEquippedWeapon()):
		if(!wasEquipped):
			color.g += 0.4
			wasEquipped = true
			equipped_.text = "[Equipped]"
	else:
		equipped_.text = "[Equip?]"
		equipped_.visible = false
		if(wasEquipped):
			color.g -= 0.4
			wasEquipped = false
	


func onPressed() -> void:
	GlobalInventory.equipWeapon(item)
