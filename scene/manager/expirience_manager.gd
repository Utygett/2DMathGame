extends Node

var s_current_exp = 0

func _ready() -> void:
	Global.expirience_bottle_colleted.connect(on_exp_bottle_collected)
	
	
func on_exp_bottle_collected(expirience):
	s_current_exp += expirience
	print(s_current_exp)
