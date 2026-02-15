extends Node2D

var pole_scene := load("res://ski/terrain/LiftPole.tscn")

@export var spacing := 48
@export var x_pos := 256

var overflow := 24
var config: GeneratorConfig

func generate(region: GenerationRegion):
	var sp: int
	var xp: int
	var scene: PackedScene

	if config:
		sp = config.extra_params.get("spacing", spacing)
		xp = config.extra_params.get("x_pos", x_pos)
		scene = config.spawn_scene if config.spawn_scene else pole_scene
	else:
		sp = spacing
		xp = x_pos
		scene = pole_scene

	while overflow < (region.height - 4):
		region.add_object(scene, xp, overflow + region.origin_y, 4, 8)
		overflow += sp
	overflow -= region.height
