extends Node

@export var anvil_ability_scene: PackedScene

const BASE_RANGE = 100
var base_damage = 15.0
var anvil_quantity = 0

func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var anvil_range = randf_range(10, BASE_RANGE)
	for i in anvil_quantity + 1:
		var spawn_position = player.global_position + direction * anvil_range
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
		if not result.is_empty():
			spawn_position = result['position']
		
		var anvil_instance = anvil_ability_scene.instantiate() as AnvilAbility
		get_tree().get_first_node_in_group('foreground_layer').add_child(anvil_instance)
		anvil_instance.global_position = spawn_position
		anvil_instance.hit_box_component.damage = base_damage
		direction = direction.rotated(TAU / (anvil_quantity + 1))


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == 'anvil_quantity':
		anvil_quantity = current_upgrades['anvil_quantity']['quantity']
