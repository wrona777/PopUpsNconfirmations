extends Resource
class_name Item

@export var name : String = "Item"
@export var upgrade_cost : int = 10
@export_multiline var description : String
@export var character_class : String
@export var icon : Texture2D
@export var rarity : String
@export var level : int = 1

func get_display_name() -> String:
	return "%s +%d" % [name, level]

func can_upgrade() -> bool:
	return level <= 9
