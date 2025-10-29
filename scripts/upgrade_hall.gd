extends Control

@onready var upgrade_square_marker = $UpgradeInterface/MarginContainer/VBoxContainer/UpgareSquare/Marker2D
@onready var name_label = $UpgradeInterface/MarginContainer/VBoxContainer/Name
@onready var cost_label = $UpgradeInterface/MarginContainer/VBoxContainer/Cost
@onready var upgrade_btn = $UpgradeInterface/MarginContainer/VBoxContainer/upgradeBtn

var is_being_upgraded = false
var primary_pos: Vector2
var current_item: Node2D

func _ready() -> void:
	for n in get_tree().get_nodes_in_group("items"):
		if n.has_signal("clicked"):
			n.clicked.connect(_on_item_clicked)

func _on_item_clicked(node, item: Item) -> void:
	if is_being_upgraded:
		if current_item == node:
			current_item.global_position = primary_pos
			current_item = null
			is_being_upgraded = false
			reset()
			return
			
		current_item.global_position = primary_pos
		
		primary_pos = node.global_position
		current_item = node
		node.global_position = upgrade_square_marker.global_position
		item_setter(item)
		
	else:
		
		primary_pos = node.global_position
		current_item = node
		node.global_position = upgrade_square_marker.global_position
		is_being_upgraded = true
		item_setter(item)

func item_setter(item: Item) -> void:
	name_label.text = item.get_display_name()
	cost_label.text = str(item.upgrade_cost)
	upgrade_btn.disabled = false

func reset() -> void:
	name_label.text = ""
	cost_label.text = ""
	upgrade_btn.disabled = true

func _on_upgrade_btn_pressed() -> void:
	var a_item = current_item.item

	var ok := await PopupManager.confirm({
		"title": "Ulepszenie " + a_item.name,
		"header": "Na pewno chcesz ulepszyć ten przedmiot?",
		"body": "Koszt: " + str(a_item.upgrade_cost),
		"accept_text": "Ulepsz",
		"cancel_text": "Anuluj"
	})

	if ok:
		a_item.level += 1
	else:
		print("Anulowano.")
	
	item_setter(a_item)
