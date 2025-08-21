extends Control
class_name MagicRow
@onready var element: TextureRect = $Element
@onready var title: RichTextLabel = $title
@onready var mp: RichTextLabel = $mp
@onready var selectedImage: TextureRect = $Selected


@export var magicReference: GDScript:
	set(value):
		magicReference = value
		magic = value.new()
		

var magic: Magic

func updateInfo() -> void:
	mp.set_text("" + str(int(magic.mp)) + " MP");
	if magic == null:
		return
	title.set_text(magic.title)

	if(magic.type == Magic.magic_type.ELEMENTAL):
		magic = magic as ElementalMagic
		element.texture = ElementalMagic.getElementTexture(magic.typeOfElement)
	else: 
		element.texture = null


func setMagic(newMagic: Magic):
	self.magic = newMagic
	updateInfo()


func _on_mouse_entered() -> void:
	get_parent().get_parent().get_parent().setFromMagic(magic)
#	selectedImage.visible = true;
	pass # Replace with function body.


func _on_mouse_exited() -> void:
#	selectedImage.visible = false;

	pass # Replace with function body.


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("correct" + str(magic.title));


	pass # Replace with function body.
