extends Node

@export_range(0, 1) var drop_percent: float = 0.5
@export var health_component: Node
@export var vial_scene: PackedScene


func _ready():
	(health_component as HealthComponent).died.connect(on_died)


func on_died():
	if vial_scene == null or not owner is Node2D or randf() > drop_percent:
		return
	
	var spawn_pos = (owner as Node2D).global_position
	var vial_instance = vial_scene.instantiate() as Node2D
	vial_instance.global_position = spawn_pos
	var entities_layer = get_tree().get_first_node_in_group('entities_layer')
	entities_layer.add_child(vial_instance)
