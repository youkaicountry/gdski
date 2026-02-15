extends Node2D

@export var spawn_scene    : PackedScene
@export var density1k      : float = 5.0
@export var object_width   : int = 1
@export var object_height  : int = 1
@export var start_x        : int = 0
@export var generate_width : int = -1

var config: GeneratorConfig

func generate(region: GenerationRegion):
	var scene: PackedScene
	var dens: float
	var ow: int
	var oh: int
	var sx: int
	var gw: int

	if config:
		scene = config.spawn_scene
		dens = config.get_density_at(region.origin_y)
		ow = config.object_width
		oh = config.object_height
		sx = config.start_x
		gw = config.generate_width
	else:
		scene = spawn_scene
		dens = density1k / 1000.0
		ow = object_width
		oh = object_height
		sx = start_x
		gw = generate_width

	if gw < 0:
		gw = region.width - sx
	region.sprinkle_objects_area(scene, dens, sx, region.origin_y, gw, region.height, ow, oh)
