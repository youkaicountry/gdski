class_name GeneratorConfig
extends Resource

@export var generator_script: Script
@export var spawn_scene: PackedScene
@export var density1k: float = 1.0
@export var object_width: int = 1
@export var object_height: int = 1
@export var start_x: int = 0
@export var generate_width: int = -1
@export var ramp_max: float = 1.0
@export var ramp_distance: int = 8000
@export var extra_params: Dictionary = {}

func get_density_at(tile_y: int) -> float:
	if ramp_max == 1.0 or ramp_distance <= 0:
		return density1k / 1000.0
	var t := clampf(float(tile_y) / float(ramp_distance), 0.0, 1.0)
	var multiplier := lerpf(1.0, ramp_max, t)
	return (density1k / 1000.0) * multiplier
