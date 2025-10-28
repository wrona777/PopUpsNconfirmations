extends Node2D

@export var item : Item
@onready var item_icon = $TextureRect

signal clicked(node, item: Item)

func _ready() -> void:
	if item != null:
		item_setter()
		item_icon.mouse_entered.connect(func(): PopupManager.show_item_tooltip(item_icon, item))
		item_icon.mouse_exited.connect(func(): PopupManager.hide_item_tooltip(item_icon))
		item_icon.tree_exited.connect(func(): PopupManager.hide_item_tooltip(item_icon))
		item_icon.gui_input.connect(_on_icon_gui_input)

func item_setter():
	item_icon.texture = item.icon

func _on_icon_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		emit_signal("clicked", self, item)

func _enter_tree() -> void:
	add_to_group("items")

func _exit_tree() -> void:
	remove_from_group("items")
