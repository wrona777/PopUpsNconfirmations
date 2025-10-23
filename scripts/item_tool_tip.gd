extends PanelContainer

@onready var _name: Label = $VBoxContainer/name
@onready var _desc: RichTextLabel = $VBoxContainer/description
@onready var _meta: RichTextLabel = $VBoxContainer/additionalInfo

const PADDING := Vector2(10, 10)

func set_item(item: Item) -> void:
	if item == null:
		hide()
		return
	_name.text = item.name
	_desc.bbcode_enabled = true
	_desc.text = item.description
	_meta.text = "Lv.%d  •  Cost: %d" % [item.level, item.upgrade_cost]

func show_at(global_anchor: Vector2) -> void:
	visible = true
	await get_tree().process_frame # why: czekaj aż UI policzy rozmiar
	var asize := get_combined_minimum_size().max(self.size)
	var desired := global_anchor - Vector2(size.x * 0.5, size.y + 8)
	position = _clamp_to_viewport(desired, asize)

func hide_tooltip() -> void:
	visible = false

func _clamp_to_viewport(p: Vector2, box: Vector2) -> Vector2:
	var vs := get_viewport_rect().size
	p.x = clampf(p.x, PADDING.x, vs.x - box.x - PADDING.x)
	p.y = clampf(p.y, PADDING.y, vs.y - box.y - PADDING.y)
	return p
