extends Node

@export var attack_ability: PackedScene

var s_attack_range = 100
var s_damage = 5


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var player_pos = player.global_position
	#Фильтруем врагов по дистнации пикселей
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy:Node2D):
		return enemy.global_position.distance_squared_to(player_pos) < pow(s_attack_range, 2)
	)
	if enemies.size() == 0:
		return
	enemies.sort_custom(func(a:Node2D, b:Node2D):
		var a_distnace = a.global_position.distance_squared_to(player_pos)
		var b_distnace = b.global_position.distance_squared_to(player_pos)
		return a_distnace < b_distnace
	)
	
	var enemy_pos = enemies[0].global_position
	
	var attack_instance = attack_ability.instantiate() as AttackAbility
	player.get_parent().get_parent().add_child(attack_instance)
	
	attack_instance.hit_box_component.damage = s_damage
	
	attack_instance.global_position = (enemy_pos + player_pos) / 2
	
	attack_instance.look_at(enemy_pos)
	
	
