extends ColorRect

@onready var grid_container: GridContainer = $TabContainer/Weapons/GridContainer
@onready var title: RichTextLabel = $Title
@onready var description: RichTextLabel = $Description
@onready var damage: RichTextLabel = $Damage
@onready var icon: TextureRect = $Icon

@onready var tab: TabBar = $TabContainer/Weapons/Tab



var resource = preload("res://assets/UI/weapon_row.tscn")

func _ready() -> void:
	if !SignalBus.is_connected("openEquipment", onOpenEquipment):
		SignalBus.openEquipment.connect(onOpenEquipment)


func onOpenEquipment():
	visible = true
	updateItems()
	
	
func _input(event):
	#if event.is_action_pressed("inventory"):
		#visible = !visible
	if event.is_action_pressed("Exit"):
		visible = false

func updateItems():

		
	for child in grid_container.get_children():
		child.queue_free()
	for item in GlobalInventory.items:
		if item is Weapon:
			if tab.current_tab == 0 && !item is Broadsword:
				continue;
			if tab.current_tab == 1 && !item is Greatsword:
				continue;
			if tab.current_tab == 2 && !item is Spear: 
				continue;
			var newThing = resource.instantiate()
			grid_container.add_child(newThing)
			if !newThing.is_connected("hovered", onItemHovered):
				newThing.hovered.connect(onItemHovered)
			newThing.setItem(item)
			
			

func onItemHovered(item: Item):
	title.text = item.title
	description.text = item.description
	icon.texture = item.icon
	
	
	


func _on_tab_tab_changed(tab: int) -> void:
	updateItems()
