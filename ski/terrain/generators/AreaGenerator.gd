extends Node2D

@export var spawn_scene    : PackedScene
@export var density1k      : float = 5.0
@export var object_width   : int = 1
@export var object_height  : int = 1
@export var start_x        : int = 0
@export var generate_width : int = -1

func _ready():
	pass

func generate(region:GenerationRegion):
	if generate_width < 0: generate_width = region.width - start_x
	region.sprinkle_objects_area(spawn_scene, density1k/1000.0, start_x, region.origin_y, generate_width, region.height, object_width, object_height)
	pass
