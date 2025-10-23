extends Node2D

@export var item : Item

func _ready() -> void:
	if item != null:
		item_setter()

func item_setter():
	print(item.name)
