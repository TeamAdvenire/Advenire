extends RichTextLabel

var item: Item
var number: int
var dying = false
@onready var icon: TextureRect = $Icon
@export var timeToLive = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func setItem(item: Item, number: int):
	self.item = item
	self.number = number
	text = "			+" + str(number) + " "+ item.title
	icon.texture = item.icon
	modulate.a = 1
	
func setOther(text: String, texture: Texture) -> void:
	self.item = Item.new("","","", Texture.new())
	self.text = text
	icon.texture = texture
	modulate.a = 1

func _process(delta: float) -> void:
	if modulate.a > 0:
		modulate.a -= delta/2;
	else:
		self.queue_free()
	
	
