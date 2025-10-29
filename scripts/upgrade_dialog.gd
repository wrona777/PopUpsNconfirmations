extends ConfirmationDialog
class_name UpgradeDialog

signal result(accepted: bool)

@onready var _header: Label         = $VBoxContainer/Label
@onready var _body: RichTextLabel   = $VBoxContainer/RichTextLabel

var _escape_closes := true

func _ready() -> void:
	visible = false
	exclusive = true    
	_body.bbcode_enabled = true
	get_ok_button().pressed.connect(_on_accept)
	var cancel_btn := get_cancel_button()
	if cancel_btn:
		cancel_btn.pressed.connect(_on_cancel)
	close_requested.connect(_on_cancel)

func prompt(opts: Dictionary) -> void:
	title = str(opts.get("title", "Confirm"))
	_header.text = str(opts.get("header", ""))
	_body.bbcode_text = str(opts.get("body", ""))
	get_ok_button().text = str(opts.get("accept_text", "OK"))
	var cancel_btn := get_cancel_button()
	if cancel_btn:
		cancel_btn.text = str(opts.get("cancel_text", "Cancel"))
		cancel_btn.visible = bool(opts.get("show_cancel", true))
	_escape_closes = bool(opts.get("escape_closes", true))

	popup_centered()
	get_ok_button().grab_focus()

func confirm(opts: Dictionary) -> bool:
	prompt(opts)
	return await result

func _on_accept() -> void:
	hide()
	emit_signal("result", true)

func _on_cancel() -> void:
	if not _escape_closes and Input.is_action_pressed("ui_cancel"):
		return
	hide()
	emit_signal("result", false)
