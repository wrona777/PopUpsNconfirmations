extends PanelContainer

@onready var _name: Label = $VBoxContainer/name
@onready var _desc: RichTextLabel = $VBoxContainer/description
@onready var _meta: RichTextLabel = $VBoxContainer/additionalInfo

const PADDING := Vector2(10, 10)

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	#_delay.timeout.connect(_on_delay_timeout)

func _process(_delta):
	if visible:
		update_follow_position()

func set_item(item: Item) -> void:
	if item == null:
		hide()
		return
	_name.text = item.name
	_desc.bbcode_enabled = true
	_desc.bbcode_text = item.description
	_meta.text = "Lv.%d  •  Cost: %d" % [item.level, item.upgrade_cost]

func update_follow_position() -> void:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var vp_rect := get_viewport_rect()
	var desired := mouse_pos + PADDING

	# Realny rozmiar tooltipa
	var tip_size := get_combined_minimum_size()
	if size.x > 0.0 and size.y > 0.0:
		tip_size = tip_size.max(size)

	# Flip w poziomie, gdy brakuje miejsca po prawej
	var right_space := vp_rect.size.x - (mouse_pos.x + PADDING.x + tip_size.x)
	if right_space < 0.0:
		desired.x = mouse_pos.x - tip_size.x - PADDING.x

	# Flip w pionie, gdy brakuje miejsca na dole
	var bottom_space := vp_rect.size.y - (mouse_pos.y + PADDING.y + tip_size.y)
	if bottom_space < 0.0:
		desired.y = mouse_pos.y - tip_size.y - PADDING.y

	# Ostateczny clamp do ekranu z paddingiem
	desired.x = clampf(desired.x, PADDING.x, vp_rect.size.x - tip_size.x - PADDING.x)
	desired.y = clampf(desired.y, PADDING.y, vp_rect.size.y - tip_size.y - PADDING.y)

	global_position = desired

func show_tooltip(item: Item) -> void:
	set_item(item)
	if item == null:
		return
	visible = true
	set_process(true)
	update_follow_position()

func hide_tooltip() -> void:
	visible = false
	set_process(false)
