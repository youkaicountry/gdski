extends Node2D

var config: GeneratorConfig

func generate(region: GenerationRegion):
	var scene := config.spawn_scene
	var dens := config.get_density_at(region.origin_y)
	var ow := config.object_width
	var oh := config.object_height
	var cluster_size: int = config.extra_params.get("cluster_size", 5)
	var cluster_spread: int = config.extra_params.get("cluster_spread", 8)

	# Number of cluster centers based on density
	var total_tiles := region.width * region.height
	var n_objects := int(total_tiles * dens)
	var n_clusters := maxi(1, n_objects / cluster_size)

	for _c in range(n_clusters):
		# Pick a random cluster center
		var cx := region.origin_x + (randi() % region.width)
		var cy := region.origin_y + (randi() % region.height)

		# Place objects around the center
		for _i in range(cluster_size):
			var ox := cx + (randi() % (cluster_spread * 2 + 1)) - cluster_spread
			var oy := cy + (randi() % (cluster_spread * 2 + 1)) - cluster_spread
			# Clamp to region bounds
			ox = clampi(ox, region.origin_x, region.origin_x + region.width - ow)
			oy = clampi(oy, region.origin_y, region.origin_y + region.height - oh)
			region.add_object(scene, ox, oy, ow, oh)
