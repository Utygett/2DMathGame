extends CharacterBody2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var grace_period: Timer = $GracePeriod

var s_max_speed = 100
var s_acceleration = 0.15
var enemies_colliding = 0

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

func check_if_damage():
	if enemies_colliding == 0 || !grace_period.is_stopped():
		return
	health_component.take_damage(1)
	grace_period.start()
	print(health_component.current_health)

func _on_player_hurt_box_area_entered(area: Area2D) -> void:
	enemies_colliding += 1
	check_if_damage()


func _on_player_hurt_box_area_exited(area: Area2D) -> void:
	enemies_colliding += 1
