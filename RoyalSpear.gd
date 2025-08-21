extends Spear
class_name RoyalSpear

func _init() -> void:
	title = "Royal Spear"
	description = "A spear used by Leisterian Knights"
	self.origin = "Dropped by certain enemies. Found in major cities"
	self.icon = load("res://assets/items/Weapon/RoyalSpear.png")
	self.mainColor = Color("b8c8cb")
	self.subColor =  Color("791b7d")
	self.spearColor =  Color("33293b")
	self.damageAmmount = 10
