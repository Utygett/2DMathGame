extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label


func damage_text(damage):
	label.text = str(damage)
	animation_player.play("damage_text")
