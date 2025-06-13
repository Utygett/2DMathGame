extends CharacterBody2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var grace_period: Timer = $GracePeriod
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var ability_manager: Node = $AbilityManager
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var movement_component: Node = $MovementComponent

	
var enemies_colliding = 0
var base_speed = 0

func _ready() -> void:
	base_speed = movement_component.max_speed
	health_component.died.connect(on_died)
	health_component.health_change.connect(on_health_changed)
	Global.ability_upgrage_added.connect(on_ability_upgrade_added)
	health_update()

func _process(_delta: float) -> void:
	var movement = movement_vector()
	var direction = movement.normalized()
	
	velocity = movement_component.accelerate_to_direction(direction)
	move_and_slide()
	if direction.y < -0.5:
		animated_sprite_2d.play("moveUp")
	elif direction.y > 0.5:
		animated_sprite_2d.play("moveDown")
	elif direction.x > 0.5:
		animated_sprite_2d.play("moveRight")
	elif direction.x < -0.5:
		animated_sprite_2d.play("moveLeft")
	else:
		animated_sprite_2d.play("idleUp")


func movement_vector():
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var movement_y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(movement_x, movement_y)

func check_if_damage():
	if enemies_colliding == 0 || !grace_period.is_stopped():
		return
	health_component.take_damage(1)
	grace_period.start()

func _on_player_hurt_box_area_entered(area: Area2D) -> void:
	enemies_colliding += 1
	check_if_damage()

func health_update():
	progress_bar.value = health_component.get_health_value()

func _on_player_hurt_box_area_exited(area: Area2D) -> void:
	enemies_colliding -= 1

func on_died():
	queue_free()

func on_health_changed():
	$AudioStreamPlayer2D.play()
	Global.player_damage.emit()
	health_update()


func _on_grace_period_timeout() -> void:
	check_if_damage()

func on_ability_upgrade_added(upgrade:AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade is NewAbility:
		var new_ability = upgrade as NewAbility
		ability_manager.add_child(new_ability.new_ability_scene.instantiate())
	elif upgrade.id == "move_speed":
		movement_component.max_speed = base_speed + \
		(base_speed * current_upgrades["move_speed"]["quantity"] * 0.1)
