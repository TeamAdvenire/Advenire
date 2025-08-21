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

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const startSprites = [
	preload("HealthBarStubbs/Left/full_left.tres"),
	preload("HealthBarStubbs/Left/1_goneLeft.tres"),
	preload("HealthBarStubbs/Left/2_goneLeft.tres"),
	preload("HealthBarStubbs/Left/3_goneLeft.tres"),
	preload("HealthBarStubbs/Left/4_goneLeft.tres"),
	preload("HealthBarStubbs/Left/5_goneLeft.tres"),
	preload("HealthBarStubbs/Left/6_goneLeft.tres"),
	preload("HealthBarStubbs/Left/7_goneLeft.tres"),
	preload("HealthBarStubbs/Left/8_goneLeft.tres"),
	preload("HealthBarStubbs/Left/9_goneLeft.tres"),
	preload("HealthBarStubbs/Left/10_goneLeft.tres"),
	preload("HealthBarStubbs/Left/emptyLeft.tres"),

]
const midSprites = [
	preload("HealthBarStubbs/Middle/full_middle.tres"),
	preload("HealthBarStubbs/Middle/1_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/2_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/3_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/4_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/5_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/6_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/7_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/8_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/9_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/10_goneMiddle.tres"),
	preload("HealthBarStubbs/Middle/emptyMiddle.tres"),

]
const endSprites = [
	preload("HealthBarStubbs/End/full_End.tres"),
	preload("HealthBarStubbs/End/1_goneEnd.tres"),
	preload("HealthBarStubbs/End/2_goneEnd.tres"),
	preload("HealthBarStubbs/End/3_goneEnd.tres"),
	preload("HealthBarStubbs/End/4_goneEnd.tres"),
	preload("HealthBarStubbs/End/5_goneEnd.tres"),
	preload("HealthBarStubbs/End/6_goneEnd.tres"),
	preload("HealthBarStubbs/End/7_goneEnd.tres"),
	preload("HealthBarStubbs/End/8_goneEnd.tres"),
	preload("HealthBarStubbs/End/9_goneEnd.tres"),
	preload("HealthBarStubbs/End/10_goneEnd.tres"),
	preload("HealthBarStubbs/End/emptyEnd.tres"),

]
@export var value: float = .2

func _ready() -> void:
	if !SignalBus.is_connected("healthChanged", _health_changed):
		SignalBus.healthChanged.connect(_health_changed) 


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


func _health_changed(newValue: Variant) -> void:
	if newValue/10 < value:
		animation_player.play("damageFlash")
	value = float(newValue/10)
	updateBar()
	pass # Replace with function body.
