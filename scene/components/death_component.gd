extends Node2D
class_name DeathComp

@onready var gpu_particles_2d: GPUParticles2D = %GPUParticles2D
@onready var sprite_offest: Node2D = $SpriteOffest

func _ready() -> void:
	$HitSoundComponent.play()
	$AudioStreamPlayer2D.play()
