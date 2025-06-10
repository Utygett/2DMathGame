extends Node

@export var exp_manager: ExpirienceManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var cur_upgrdaes = {}

func _ready() -> void:
	exp_manager.level_up.connect(on_level_up)
	
	
func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = cur_upgrdaes.has(upgrade.id)
	if !has_upgrade:
		cur_upgrdaes[upgrade.id] = {
			"upgrde": upgrade,
			"quantity": 1
		}
	else:
		cur_upgrdaes[upgrade.id]["quantity"] += 1
	Global.ability_upgrage_added.emit(upgrade, cur_upgrdaes)
	
	if upgrade.max_quantity > 0:
		var current_quantity = cur_upgrdaes[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool = upgrade_pool.filter(func(pool_upgrade): return pool_upgrade.id != upgrade.id) 
		
	

func pick_upgrades():
	var chosen_upgrades: Array[AbilityUpgrade]
	var pool_copy = upgrade_pool.duplicate()
	for i in 2:
		if pool_copy.size() == 0:
			break
		var chosen_upgrade = pool_copy.pick_random() as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
		pool_copy = pool_copy.filter(func(upgrade): return upgrade.id != chosen_upgrade.id)
		
	return chosen_upgrades


func on_upgrade_selected(upgrade:AbilityUpgrade):
	apply_upgrade(upgrade)

func on_level_up(cur_level):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
