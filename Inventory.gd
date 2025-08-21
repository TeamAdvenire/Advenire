extends Node

signal itemAdded(Item) 
signal itemHovered(Item)

signal xpAdded(xpAmmount: float, texture: Texture)


func _ready() -> void:
	var weapon = Default.new()
	equippedWeapon = weapon


#
# XP
#


var xp: float = 1
var level: int = 1

func addXP(xpAmmount: float, texture: Texture) -> void:
	xp += xpAmmount
	while(xp >= (level + 1)):
		level += 1
		xp -= (level)
	print("XP " + str(xp))
	print("level " + str(level))
	
	xpAdded.emit(xpAmmount, texture)

func getXp() -> float:
	return xp

func getCurrentLevel() -> int:
	return level;
	
func getXpUntilLevel() -> float:
	return ((level + 1)) - xp;


# 
# Inventory
# 

var items: Array[Item] = [] 

var equippedWeapon: Weapon

signal weaponChanged(Weapon)

func addItem(item: Item) -> void: # adds an item to your inventory
	print("item Added: " + item.title)
	item.onAdd()
	items.append(item)
	itemAdded.emit(item)

func getItem(itemToUse: Item) -> Item: # returns first index of that item and returns it. 
	for item in items:
		if item.isEquel(itemToUse):
			return item
	return null;

func getEquippedWeapon() -> Weapon:
	return equippedWeapon

func equipWeapon(weapon: Weapon) -> void:
	equippedWeapon.onRemove()
	equippedWeapon = weapon
	weapon.onEquip()
	weaponChanged.emit(weapon)

func removeItem(itemToUse: Item) -> void:
	itemToUse.onRemove()
	items.erase(itemToUse);

#
# Magic
#

var magics: Array[Magic] = [ExampleMagic.new(), RocksMagic.new(), Fireball.new()]

func getMagics() -> Array[Magic]:
	return magics
