extends PanelContainer
class_name AbilityUpgradeCard

signal card_selected

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel

func set_ability_upgrade(uprgade:AbilityUpgrade):
	name_label.text = uprgade.name
	description_label.text = uprgade.description


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		card_selected.emit()
