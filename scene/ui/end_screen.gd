extends CanvasLayer
class_name EndScreen
@onready var name_label: Label = %NameLabel

func _ready() -> void:
	get_tree().paused = true

func change_to_victory():
	name_label.text = "Victory"

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/levels/level.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
