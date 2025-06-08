extends Node

@export var exp_manager: ExpirienceManager
@export var upgrade_pool: Array[AbilityUpgrade]
@export var upgrade_screen_scene: PackedScene

var cur_upgrdaes = {}

func _ready() -> void:
	exp_manager.level_up.connect(on_level_up)
	
func on_level_up(cur_level):
	var choosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if choosen_upgrade == null:
		return
		
	var upgrade_screen_instance = upgrade_screen_scene.instantiate() as UpgradeScreen
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([choosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)

	
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
		
	
func on_upgrade_selected(upgrade:AbilityUpgrade):
	apply_upgrade(upgrade)
