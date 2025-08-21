extends Control


@onready var stats: RichTextLabel = $Stats #heath values



# Level 20
# Hp: 40/40
# Mp: 40/40
# Current Weapon:
# Violin
var level: int = 1 # Not configured
var hp: float = 100
var mp: int = 0 # Not configured 
var money: float = 0 # Not configured

@onready var till_level: RichTextLabel = $TillLevel
# Till 21: 180 xp

@onready var stats_2: RichTextLabel = $Stats2 #constant values

# ATC: 
# DEF:
# MAG:
# SPD:

var def: float = 0 # Not configured
var mag: float = 0 # Not configured
var spd: float = 1.0 # Not configured

@onready var quest_label: RichTextLabel = $Stats3 #Current Quest

# Current Quest:
var quest: String = "Work on the game" # Not configured




func _ready() -> void:
	if !SignalBus.is_connected("healthChanged", healthChanged):
		SignalBus.healthChanged.connect(healthChanged)
	if !GlobalInventory.is_connected("weaponChanged", weaponChanged):
		GlobalInventory.weaponChanged.connect(weaponChanged)
	if !GlobalInventory.is_connected("xpAdded", xpChanged):
		GlobalInventory.xpAdded.connect(xpChanged)
	updateStats1()
	updateStats2()
	updateQuest()

func weaponChanged(weapon: Weapon) -> void:
	updateStats1()
	updateStats2()

func healthChanged(newValue: float):
	hp = newValue
	updateStats1()

func xpChanged(xp: float, tex: Texture):
	updateStats1()
	
	
func updateStats1():
	stats.text = "Level " + str(GlobalInventory.getCurrentLevel())
	till_level.text = "Till " + str(GlobalInventory.getCurrentLevel() + 1) + ": " + str(GlobalInventory.getXpUntilLevel())
	stats.text += "\nHp: " + str(hp) + "/100"
	stats.text += "\nMp: " + str(mp) + "/100"
	stats.text += "\n$ " + str(money)
	stats.text += "\nCurrent Weapon: \n" + GlobalInventory.getEquippedWeapon().title

func updateStats2():
	stats_2.text = "ATC: " + str(GlobalInventory.getEquippedWeapon().damageAmmount)
	stats_2.text += "\nDEF: " + str(def)
	stats_2.text += "\nMAG: " + str(mag)
	stats_2.text += "\nSPD: " + str(spd) + "x"

func updateQuest():
	quest_label.text = "Current Quest: \n" + quest
