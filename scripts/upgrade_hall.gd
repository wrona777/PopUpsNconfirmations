extends Control

func _ready() -> void:
	for n in get_tree().get_nodes_in_group("items"):
		if n.has_signal("clicked"):
			n.clicked.connect(_on_item_clicked)

func _on_item_clicked(node, item: Item) -> void:
	print("e")
