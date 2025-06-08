extends Node
class_name ExpirienceManager

signal expirince_update (s_current_exp:float, target_exp:float)
signal level_up (cur_level)

var s_current_exp = 0
var target_exp	 = 1
var target_after_lvlup = 5
var current_level = 1

func _ready() -> void:
	Global.expirience_bottle_colleted.connect(on_exp_bottle_collected)
	
	
func on_exp_bottle_collected(expirience):
	s_current_exp = min(s_current_exp + expirience, target_exp)
	expirince_update.emit(s_current_exp, target_exp)
	
	if s_current_exp == target_exp:
		current_level += 1
		s_current_exp = 0
		target_exp += target_after_lvlup
		expirince_update.emit(s_current_exp, target_exp)
		level_up.emit(current_level)
