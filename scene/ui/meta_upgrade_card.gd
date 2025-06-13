extends PanelContainer
class_name MetaUpgradeCard

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func set_meta_upgrade(uprgade:MetaUpgrade):
	name_label.text = uprgade.name
	description_label.text = uprgade.description
