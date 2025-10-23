extends Node2D

@export var item : Item
@onready var item_icon = $TextureRect

func _ready() -> void:
	if item != null:
		item_setter()
		item_icon.mouse_entered.connect(func(): PopupManager.show_item_tooltip(item, item_icon))
		item_icon.mouse_exited.connect(func(): PopupManager.hide_item_tooltip())

func item_setter():
	item_icon.texture = item.icon
