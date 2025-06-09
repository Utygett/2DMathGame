extends Node2D
class_name AxeAbility

@onready var hit_box_component: HitBoxComponent = $HitBoxComponent

var max_axe_radius = 100
var base_direction = Vector2.RIGHT

func _ready() -> void:
	base_direction = base_direction.rotated(randf_range(0.0, TAU))
	var tween = create_tween()
	tween.tween_method(rotate_animation, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)
	
func rotate_animation(rotations):
	var percnet = rotations / 2
	var axe_current_radius = percnet * max_axe_radius
	var axe_current_direction  = base_direction.rotated(rotations * TAU)
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	global_position = player.global_position + (axe_current_direction * axe_current_radius)
