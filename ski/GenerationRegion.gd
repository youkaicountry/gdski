class_name GenerationRegion
extends Node2D

var blocked := []
var width   : int
var height  : int
var tile_width  : float
var tile_height : float
var origin_x       : int
var origin_y       : int

func _init(x:int, y:int, w:int, h:int, tile_width:float, tile_height:float) -> void:
	self.origin_x = x
	self.origin_y = y
	self.width = w
	self.height = h
	self.tile_width = tile_width
	self.tile_height = tile_height
	self.blocked.resize(w*h)
	pass

func sprinkle_objects(obj:PackedScene, density:float, ow:int, oh:int) -> void:
	self.sprinkle_objects_area(obj, density, self.origin_x, self.origin_y, self.width, self.height, ow, oh)

# x/y + rw/rh is the region in which to place the objects
# ow, oh is the object size
func sprinkle_objects_area(obj:PackedScene, density:float, x:int, y:int, rw:int, rh:int, ow:int, oh:int) -> void:
	var n = int((rw*rh) * density)
	#print(n)
	for i in range(n):
		var placed := false
		while not placed:
			var eff_w := rw - (ow-1)
			var eff_h := rh - (oh-1)
			var px := x+(randi()%eff_w)
			var py := y+(randi()%eff_h)
			#print(eff_w, " ", eff_h)
			placed = self.add_object(obj, px, py, ow, oh)

func add_object(obj:PackedScene, x:int, y:int, w:int, h:int) -> bool:
	# TODO: Check the given spaces for clearance
	if self.is_region_blocked(x, y, w, h): return false
	self.block_region(x, y, w, h)
	var node = obj.instance() as Node2D
	node.position = Vector2((x-self.origin_x)*self.tile_width, (y-self.origin_y)*self.tile_height)
	self.add_child(node)
	return true

func block_region(x:int, y:int, w:int, h:int) -> void:
	for iy in range(y, y+h):
		for ix in range(x, x+w):
			self.blocked[self.get_blocked_index(ix, iy)] = true
			
func is_region_blocked(x:int, y:int, w:int, h:int) -> bool:
	for iy in range(y, y+h):
		for ix in range(x, x+w):
			if self.blocked[self.get_blocked_index(ix, iy)]: return true
	return false

func get_blocked_index(x:int, y:int) -> int:
	return (y-self.origin_y) * self.width + (x-self.origin_x)
