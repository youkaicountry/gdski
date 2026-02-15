extends Node2D

var config: GeneratorConfig

func generate(region: GenerationRegion):
	var clearing_chance: float = config.extra_params.get("clearing_chance", 0.3)
	var min_size: int = config.extra_params.get("min_size", 20)
	var max_size: int = config.extra_params.get("max_size", 60)

	if randf() > clearing_chance:
		return

	var cw := min_size + (randi() % (max_size - min_size + 1))
	var ch := min_size + (randi() % (max_size - min_size + 1))
	cw = mini(cw, region.width)
	ch = mini(ch, region.height)

	var cx := region.origin_x + (randi() % (region.width - cw + 1))
	var cy := region.origin_y + (randi() % (region.height - ch + 1))

	# Block the area without placing any objects
	region.block_region(cx, cy, cw, ch)
