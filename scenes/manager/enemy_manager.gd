extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0
var enemy_table = WeightedTable.new()

func _ready():
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	arena_time_manager.arena_difficulty_increased.connect(_on_arena_difficulty_increased)


func _on_timer_timeout():
	timer.start()
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	for i in 4:
		var spawn_position = player.global_position + random_direction * SPAWN_RADIUS
		var addt_check_offset = random_direction * 20
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + addt_check_offset, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		if result.is_empty():
			var enemy_scene = enemy_table.pick_item()
			var enemy = enemy_scene.instantiate() as Node2D
			enemy.global_position = spawn_position
			var entities_layer = get_tree().get_first_node_in_group('entities_layer')
			entities_layer.add_child(enemy)
			return
		random_direction = Vector2.RIGHT.rotated(PI / 2)


func _on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = min((0.1 / 12) *  arena_difficulty, 0.7)
	timer.wait_time = base_spawn_time - time_off
	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
