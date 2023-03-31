extends Node2D

var pole_scene := load("res://ski/terrain/LiftPole.tscn")

@export var spacing := 48
@export var x_pos := 256

var overflow := 24

func generate(region:GenerationRegion):
	while overflow < (region.height-4):
		region.add_object(pole_scene, x_pos, overflow+region.origin_y, 4, 8)
		overflow += spacing
	overflow -= region.height
