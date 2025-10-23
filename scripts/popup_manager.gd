extends CanvasLayer

@onready var _root: Control = $Root
@onready var _tooltip: Node = $Root/ItemToolTip
@onready var _upgrade: Node = $Root/upgradeDialog

func show_item_tooltip(item: Item, a_owner: Control) -> void:
	if a_owner == null or item == null:
		return
	_tooltip.set_item(item)
	var r: Rect2 = a_owner.get_global_rect()
	var anchor := Vector2(r.position.x + r.size.x * 0.5, r.position.y)
	_tooltip.show_at(anchor)

func hide_item_tooltip() -> void:
	_tooltip.hide_tooltip()
