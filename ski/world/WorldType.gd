class_name WorldType
extends Resource

@export var world_name: String = ""
@export var course_length: int = -1  # -1 = infinite
@export var generators: Array[GeneratorConfig] = []
@export var yeti_distance: int = -1  # -1 = no yeti
