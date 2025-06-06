extends Node2D

var bottle_exp = 5

func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.expirience_bottle_colleted.emit(bottle_exp)
	queue_free()
