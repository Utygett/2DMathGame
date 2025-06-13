extends PanelContainer
class_name MetaUpgradeCard

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel

var s_upgrade:MetaUpgrade

func set_meta_upgrade(upgrade:MetaUpgrade):
	self.s_upgrade = upgrade
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	update_progress()

func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"]
	var percent = currency / s_upgrade.cost
	percent = min(percent, 1)
	progress_bar.value = percent
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency as int) + " / " + str(s_upgrade.cost)


func _on_purchase_button_pressed() -> void:
	if s_upgrade == null:
		return
	MetaProgression.add_meta_upgrade(s_upgrade)
	MetaProgression.save_data["meta_upgrade_currency"] -= s_upgrade.cost
	MetaProgression.save_file()
	get_tree().call_group("meta_upgrade_card", update_progress())
	animation_player.play("selected")
