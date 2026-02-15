class_name WorldTypes

static var _area_gen: Script = preload("res://ski/terrain/generators/AreaGenerator.gd")
static var _lift_gen: Script = preload("res://ski/terrain/generators/LiftPoleGenerator.gd")
static var _cluster_gen: Script = preload("res://ski/terrain/generators/ClusterGenerator.gd")
static var _pattern_gen: Script = preload("res://ski/terrain/generators/PatternGenerator.gd")
static var _clearing_gen: Script = preload("res://ski/terrain/generators/ClearingGenerator.gd")

static var _big_tree: PackedScene = preload("res://ski/terrain/BigTree.tscn")
static var _small_tree: PackedScene = preload("res://ski/terrain/SmallTree.tscn")
static var _dead_tree: PackedScene = preload("res://ski/terrain/DeadTree.tscn")
static var _big_bump: PackedScene = preload("res://ski/terrain/BigBump.tscn")
static var _small_bump: PackedScene = preload("res://ski/terrain/SmallBump.tscn")
static var _rock: PackedScene = preload("res://ski/terrain/Rock.tscn")
static var _rough: PackedScene = preload("res://ski/terrain/Rough.tscn")
static var _stump: PackedScene = preload("res://ski/terrain/Stump.tscn")
static var _lift_pole: PackedScene = preload("res://ski/terrain/LiftPole.tscn")
static var _slalom_gate: PackedScene = preload("res://ski/terrain/SlalomGate.tscn")
static var _ramp: PackedScene = preload("res://ski/terrain/Ramp.tscn")
static var _dog: PackedScene = preload("res://ski/terrain/Dog.tscn")
static var _skier_npc: PackedScene = preload("res://ski/terrain/SkierNPC.tscn")
static var _snowboarder: PackedScene = preload("res://ski/terrain/Snowboarder.tscn")
static var _lodge: PackedScene = preload("res://ski/terrain/Lodge.tscn")
static var _yeti: PackedScene = preload("res://ski/terrain/Yeti.tscn")


static func _cfg(script: Script, scene: PackedScene, density: float,
		ow: int = 1, oh: int = 1, ramp_max: float = 1.0,
		ramp_distance: int = 8000, extra: Dictionary = {},
		start_x: int = 0, generate_width: int = -1) -> GeneratorConfig:
	var c := GeneratorConfig.new()
	c.generator_script = script
	c.spawn_scene = scene
	c.density1k = density
	c.object_width = ow
	c.object_height = oh
	c.ramp_max = ramp_max
	c.ramp_distance = ramp_distance
	c.extra_params = extra
	c.start_x = start_x
	c.generate_width = generate_width
	return c


static func free_ski() -> WorldType:
	var wt := WorldType.new()
	wt.world_name = "Free Ski"
	wt.course_length = -1
	wt.yeti_distance = 7800
	wt.generators = [
		# Clearings first
		_cfg(_clearing_gen, null, 0, 1, 1, 1.0, 8000,
			{"clearing_chance": 0.3, "min_size": 20, "max_size": 60}),
		# Lift poles
		_cfg(_lift_gen, _lift_pole, 0, 4, 8, 1.0, 8000,
			{"spacing": 48, "x_pos": 256}),
		# Trees - BigTree clustered with ramp
		_cfg(_cluster_gen, _big_tree, 0.197, 4, 8, 2.5, 8000,
			{"cluster_size": 5, "cluster_spread": 8}),
		# SmallTree with ramp
		_cfg(_area_gen, _small_tree, 1.58, 3, 3, 2.0, 8000),
		# DeadTree
		_cfg(_area_gen, _dead_tree, 0.218, 3, 3),
		# Rough
		_cfg(_area_gen, _rough, 0.218, 5, 3),
		# BigBump
		_cfg(_area_gen, _big_bump, 0.14, 3, 2),
		# SmallBump
		_cfg(_area_gen, _small_bump, 0.492, 2, 2),
		# Rock with ramp
		_cfg(_area_gen, _rock, 0.452, 3, 2, 1.8, 8000),
		# Stump
		_cfg(_area_gen, _stump, 0.197, 2, 2),
		# NPCs
		_cfg(_area_gen, _dog, 0.05, 2, 2),
		_cfg(_area_gen, _skier_npc, 0.08, 2, 3),
		_cfg(_area_gen, _snowboarder, 0.06, 2, 3),
	]
	return wt


static func slalom() -> WorldType:
	var wt := WorldType.new()
	wt.world_name = "Slalom"
	wt.course_length = 540
	wt.yeti_distance = -1
	wt.generators = [
		# Slalom gates in zigzag pattern
		_cfg(_pattern_gen, _slalom_gate, 1.0, 2, 2, 1.0, 8000,
			{"y_spacing": 16, "x_center": 256, "x_amplitude": 25}),
		# Light trees
		_cfg(_area_gen, _small_tree, 0.3, 3, 3),
		# Rocks
		_cfg(_area_gen, _rock, 0.15, 3, 2),
		# Lift poles
		_cfg(_lift_gen, _lift_pole, 0, 4, 8, 1.0, 8000,
			{"spacing": 48, "x_pos": 480}),
	]
	return wt


static func tree_slalom() -> WorldType:
	var wt := WorldType.new()
	wt.world_name = "Tree Slalom"
	wt.course_length = 1040
	wt.yeti_distance = -1
	wt.generators = [
		# Slalom gates
		_cfg(_pattern_gen, _slalom_gate, 1.0, 2, 2, 1.0, 8000,
			{"y_spacing": 16, "x_center": 256, "x_amplitude": 25}),
		# BigTree clustered with ramp
		_cfg(_cluster_gen, _big_tree, 0.3, 4, 8, 2.0, 8000,
			{"cluster_size": 5, "cluster_spread": 8}),
		# SmallTree
		_cfg(_area_gen, _small_tree, 0.8, 3, 3),
		# DeadTree
		_cfg(_area_gen, _dead_tree, 0.15, 3, 3),
		# Rock
		_cfg(_area_gen, _rock, 0.2, 3, 2),
		# Lift poles
		_cfg(_lift_gen, _lift_pole, 0, 4, 8, 1.0, 8000,
			{"spacing": 48, "x_pos": 480}),
	]
	return wt


static func freestyle() -> WorldType:
	var wt := WorldType.new()
	wt.world_name = "Freestyle"
	wt.course_length = 1040
	wt.yeti_distance = -1
	wt.generators = [
		# Extra clearings
		_cfg(_clearing_gen, null, 0, 1, 1, 1.0, 8000,
			{"clearing_chance": 0.4, "min_size": 20, "max_size": 60}),
		# Ramps
		_cfg(_area_gen, _ramp, 0.4, 3, 2),
		# BigBump
		_cfg(_area_gen, _big_bump, 0.5, 3, 2),
		# SmallBump
		_cfg(_area_gen, _small_bump, 0.8, 2, 2),
		# SmallTree
		_cfg(_area_gen, _small_tree, 0.4, 3, 3),
		# Rock
		_cfg(_area_gen, _rock, 0.2, 3, 2),
		# Lift poles
		_cfg(_lift_gen, _lift_pole, 0, 4, 8, 1.0, 8000,
			{"spacing": 48, "x_pos": 480}),
	]
	return wt
