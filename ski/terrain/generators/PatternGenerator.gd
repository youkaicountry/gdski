extends Node2D

var config: GeneratorConfig
var overflow := 0

func generate(region: GenerationRegion):
	var scene := config.spawn_scene
	var ow := config.object_width
	var oh := config.object_height
	var y_spacing: int = config.extra_params.get("y_spacing", 16)
	var x_center: int = config.extra_params.get("x_center", 256)
	var x_amplitude: int = config.extra_params.get("x_amplitude", 25)

	# Zigzag pattern: alternates left/right of center
	var y := overflow
	var side := 1
	while y < region.height:
		var px := x_center + (x_amplitude * side)
		px = clampi(px, region.origin_x, region.origin_x + region.width - ow)
		var py := y + region.origin_y
		region.add_object(scene, px, py, ow, oh)
		side *= -1
		y += y_spacing
	overflow = y - region.height
