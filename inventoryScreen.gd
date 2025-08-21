extends ColorRect

@onready var grid_container: GridContainer = $GridContainer
@onready var title: RichTextLabel = $RichTextLabel
@onready var subTitle: RichTextLabel = $RichTextLabel2
@onready var itemImage: TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !GlobalInventory.is_connected("itemHovered", onHovered):
		GlobalInventory.itemHovered.connect(onHovered)
	if !SignalBus.is_connected("openInventory", onOpenInventory):
		SignalBus.openInventory.connect(onOpenInventory)
	title.text = ""
	subTitle.text = ""
	itemImage.texture = load("res://assets/UI/UI Hotbar.png")
	itemImage.modulate.a = 0.5

func onOpenInventory():
	visible = true
func _input(event):
	#if event.is_action_pressed("inventory"):
		#visible = !visible
	if event.is_action_pressed("Exit"):
		visible = false

func onHovered(item: Item):
	if item == null:
		title.text = ""
		subTitle.text = ""
		itemImage.texture = load("res://assets/UI/UI Hotbar.png")
		itemImage.modulate.a = 0.5
		return
	itemImage.modulate.a = 1
	title.text = item.title
	subTitle.text = item.description
	itemImage.texture = item.icon
