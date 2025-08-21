extends HBoxContainer

@onready var texture_rect: TextureRect = $TextureRect
@onready var texture_rect_2: TextureRect = $TextureRect2
@onready var texture_rect_3: TextureRect = $TextureRect3
@onready var texture_rect_4: TextureRect = $TextureRect4
@onready var texture_rect_5: TextureRect = $TextureRect5
@onready var texture_rect_6: TextureRect = $TextureRect6
@onready var texture_rect_7: TextureRect = $TextureRect7
@onready var texture_rect_8: TextureRect = $TextureRect8
@onready var texture_rect_9: TextureRect = $TextureRect9
@onready var texture_rect_10: TextureRect = $TextureRect10

# @onready var animation_player: AnimationPlayer = $AnimationPlayer

const startSprites = [
	preload("ManaBarStubbs/Left/MP_00.png"),
	preload("ManaBarStubbs/Left/MP_01.png"),
	preload("ManaBarStubbs/Left/MP_02.png"),
	preload("ManaBarStubbs/Left/MP_03.png"),
	preload("ManaBarStubbs/Left/MP_04.png"),
	preload("ManaBarStubbs/Left/MP_05.png"),
	preload("ManaBarStubbs/Left/MP_06.png"),
	preload("ManaBarStubbs/Left/MP_07.png"),
	preload("ManaBarStubbs/Left/MP_08.png"),
	preload("ManaBarStubbs/Left/MP_09.png"),
	preload("ManaBarStubbs/Left/MP_10.png"),
	preload("ManaBarStubbs/Left/MP_11.png"),

]
const midSprites = [
	preload("ManaBarStubbs/Middle/MP_12.png"),
	preload("ManaBarStubbs/Middle/MP_13.png"),
	preload("ManaBarStubbs/Middle/MP_14.png"),
	preload("ManaBarStubbs/Middle/MP_15.png"),
	preload("ManaBarStubbs/Middle/MP_16.png"),
	preload("ManaBarStubbs/Middle/MP_17.png"),
	preload("ManaBarStubbs/Middle/MP_18.png"),
	preload("ManaBarStubbs/Middle/MP_19.png"),
	preload("ManaBarStubbs/Middle/MP_20.png"),
	preload("ManaBarStubbs/Middle/MP_21.png"),
	preload("ManaBarStubbs/Middle/MP_22.png"),
	preload("ManaBarStubbs/Middle/MP_23.png"),

]
const endSprites = [
	preload("ManaBarStubbs/End/MP_24.png"),
	preload("ManaBarStubbs/End/MP_25.png"),
	preload("ManaBarStubbs/End/MP_26.png"),
	preload("ManaBarStubbs/End/MP_27.png"),
	preload("ManaBarStubbs/End/MP_28.png"),
	preload("ManaBarStubbs/End/MP_29.png"),
	preload("ManaBarStubbs/End/MP_30.png"),
	preload("ManaBarStubbs/End/MP_31.png"),
	preload("ManaBarStubbs/End/MP_32.png"),
	preload("ManaBarStubbs/End/MP_33.png"),
	preload("ManaBarStubbs/End/MP_34.png"),
	preload("ManaBarStubbs/End/MP_35.png"),

]


@export var value: float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !SignalBus.is_connected("manaChanged", manaChanged):
		SignalBus.manaChanged.connect(manaChanged) 
	updateBar()


func updateBar():
	var bars = [texture_rect, texture_rect_2, texture_rect_3, texture_rect_4, texture_rect_5, texture_rect_6, texture_rect_7, texture_rect_8, texture_rect_9, texture_rect_10]
	for i in bars.size():
		var toUse: float = (i - value) * -12  # calculate mid-intersection point for texture
		if (toUse > 11):
			toUse = 11
		if (toUse < 0): 
			toUse = 0
			# Set textures!
		if (i == 0): # starting sprite
			bars[i].texture = startSprites[11 - toUse]
		elif (i < (bars.size() - 1)): # mid sprites
			bars[i].texture = midSprites[11 - toUse]
		else: # end sprite 
			bars[i].texture = endSprites[11 - toUse]
		if (i > (bars.size() - 1)): # if value is outside of range based on Max
			bars[i].texture = endSprites[0]


func manaChanged(newValue):
	print("changed " + str(newValue))
	self.value = newValue/10
	updateBar()



