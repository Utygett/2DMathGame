extends Node

@export var exp_manager: ExpirienceManager
@export var upgrade_pool: Array[AbilityUpgrade]

var cur_upgrdaes = {}

func _ready() -> void:
	exp_manager.level_up.connect(on_level_up)
	
func on_level_up(cur_level):
	var choosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if choosen_upgrade == null:
		return
	
	var has_upgrade = cur_upgrdaes.has(choosen_upgrade.id)
	if !has_upgrade:
		cur_upgrdaes[choosen_upgrade.id] = {
			"upgrde": choosen_upgrade,
			"quantity": 1
		}
	else:
		cur_upgrdaes[choosen_upgrade.id]["quantity"] += 1
	print(cur_upgrdaes)
		
	
