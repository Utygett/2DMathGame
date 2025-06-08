extends PanelContainer
class_name AbilityUpgradeCard

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel

func set_ability_upgrade(uprgade:AbilityUpgrade):
	name_label.text = uprgade.name
	description_label.text = uprgade.description
