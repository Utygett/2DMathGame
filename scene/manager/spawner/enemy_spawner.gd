extends Node

@onready var timer: Timer = $Timer

@export var plus_monster_scene: PackedScene
@export var arena_time_manager: ArenaTimerManager

var base_spawn_time
var min_spawn_time = 0.2
var difficulty_multiplier = 0.01

func _ready() -> void:
	base_spawn_time = timer.wait_time
	arena_time_manager.difficulty_increased.connect(on_difficulty_increased)

func get_spawn_position():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	var spawn_pos = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var random_distance = randi_range(300, 500)
	for i in 4:
		spawn_pos = player.global_position + (random_direction * random_distance)
		#Пересечение луча 2д
		var raycast = PhysicsRayQueryParameters2D.create(player.global_position, spawn_pos, 1)
		var intersection = get_tree().root.world_2d.direct_space_state.intersect_ray(raycast)
		if intersection.is_empty():
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	return spawn_pos

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemy = plus_monster_scene.instantiate() as Node2D
	var back_layer = get_tree().get_first_node_in_group("back_layer")
	back_layer.add_child(enemy)
	
	enemy.global_position = get_spawn_position()

func on_difficulty_increased(difficulty_level:int):
	var new_spawn_time = max(base_spawn_time - (difficulty_level * difficulty_multiplier), min_spawn_time)
	timer.wait_time = new_spawn_time
