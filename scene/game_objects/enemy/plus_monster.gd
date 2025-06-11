extends CharacterBody2D

var s_max_speed = 40

@onready var health_component: Node = $HealthComponent

@export var death_scene: PackedScene
@export var sprite: CompressedTexture2D

func _ready() -> void:
	health_component.died.connect(on_died)

func _process(_delta: float) -> void:
	var direction = get_direction_to_player()
	velocity = s_max_speed * direction
	move_and_slide()


func get_direction_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player != null:  
		return (player.global_position - self.global_position).normalized()
	return Vector2.ZERO
	
func on_died():
	var back_layer = get_tree().get_first_node_in_group("back_layer")
	var death_instance = death_scene.instantiate() as DeathComp
	back_layer.add_child(death_instance)
	death_instance.gpu_particles_2d.texture = sprite
	death_instance.global_position = global_position
	queue_free()
