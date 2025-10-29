extends CanvasLayer

@onready var tooltip: PanelContainer = $Root/ItemToolTip
@onready var dialog: UpgradeDialog = $Root/upgradeDialog

func show_item_tooltip(_owner: Control, item: Item) -> void:
	if tooltip == null or item == null:
		return
	tooltip.show_tooltip(item)

func hide_item_tooltip(_owner: Control) -> void:
	if tooltip == null:
		return	 
	tooltip.hide_tooltip()

func confirm(opts: Dictionary) -> bool:
	return await dialog.confirm(opts)
