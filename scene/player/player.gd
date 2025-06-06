extends CharacterBody2D

var s_max_speed = 100
var s_acceleration = 0.15

func _process(_delta: float) -> void:
	var movement = movement_vector()
	var direction = movement.normalized()
	var target_velocity = s_max_speed * direction
	
	velocity = velocity.lerp(target_velocity, s_acceleration)
	move_and_slide()

func movement_vector():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x, movement_y)
