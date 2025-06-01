extends CharacterBody2D

var s_max_speed = 40

func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = s_max_speed * direction
	move_and_slide()


func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:  
		return (player.global_position - self.global_position).normalized()
	return Vector2.ZERO
