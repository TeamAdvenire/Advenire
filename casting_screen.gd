extends Control

@onready var line: Line2D = $Line2D


@onready var title: RichTextLabel = $ItemDesc/Title
@onready var desc: RichTextLabel = $ItemDesc/Description

@onready var img: TextureRect = $ItemDesc/InnerItem


@onready var window := $ItemDesc

var magicToUse: Magic


var position1 := 1400
var position2 := 100

func _ready() -> void:
	if !SignalBus.is_connected("startRadialMenu", startRadialMenu):
		SignalBus.startRadialMenu.connect(startRadialMenu)
	visible = false


func _process(delta: float) -> void:
	if visible:
		var mousePos = get_global_mouse_position()
		var screenRect = get_viewport().get_visible_rect().size / 2.0

		if (screenRect.x - mousePos.x < 0):
			window.position.x = position2
		else: 
			window.position.x = position1

		line.clear_points()
		line.add_point(screenRect)
		line.add_point(mousePos);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Exit"):
		visible = false
		SignalBus.pause.emit(false)
	if visible && event.is_action_pressed("attack"):
		visible = false
		magicToUse.use((get_viewport().get_visible_rect().size / 2.0) - get_global_mouse_position())
		SignalBus.openMagic.emit(false)


func startRadialMenu(magic: Magic) -> void:
	visible = true
	self.magicToUse = magic
	refreshInfo()


func refreshInfo():
	title.set_text(magicToUse.title + " (" + str(magicToUse.mp) + " MP)")
	desc.set_text(magicToUse.description)
	if (magicToUse.type == Magic.magic_type.ELEMENTAL):
		img.texture = ElementalMagic.getElementTexture(magicToUse.typeOfElement)
	else: 
		img.texture = null
