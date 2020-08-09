extends Node2D

export var tile_size := 16.0
export var tiles_across := 512
export var tiles_down   := 64
export var camera_node : NodePath

export var bottom_gen_buffer := 2
export var top_degen_buffer := 8

var next_region := 0

onready var camera = get_node(camera_node) as Camera2D

func _ready():
	self.spawn_region()
	pass

func _physics_process(delta):
	var cp = self.camera.global_position as Vector2
	var vps := (get_viewport_rect().size * self.camera.zoom) as Vector2
	var vpsx := vps.x / 2.0
	var vpsy := vps.y / 2.0
	
	var screen := Rect2(cp.x - vpsx, cp.y - vpsy, vps.x, vps.y)
	
	# Check if generation is needed
	var bottom := screen.position.y + screen.size.y + (bottom_gen_buffer*tile_size)
	while bottom > (self.next_region * self.tiles_down * tile_size):
		self.spawn_region()
	
	var top := screen.position.y - (top_degen_buffer*tile_size)
	for child in $Regions.get_children():
		if (child.global_position.y + (tiles_down*tile_size)) < top:
			child.queue_free()

func spawn_region() -> void:
	var region = GenerationRegion.new(0, self.tiles_down*self.next_region, 
									  tiles_across, tiles_down, tile_size, tile_size)
	for generator in $Generators.get_children():
		generator.generate(region)
	region.position = Vector2(0, self.next_region*tiles_down*tile_size)
	$Regions.add_child(region)
	self.next_region += 1
	pass
