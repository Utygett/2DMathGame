extends Timer

@export var attack_ability: PackedScene


func _on_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	var attack_instance = attack_ability.instantiate() as Node2D
	player.get_parent().get_parent().add_child(attack_instance)
	attack_instance.global_position = player.global_position
