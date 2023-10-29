extends Node

const MAX_RANGE = pow(150, 2)

@export var sword_ability: PackedScene
var base_damage = 5.0
var damage_percent = 1.0
var base_wait_timer: float

func _ready():
	base_wait_timer = 1.5
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	

func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < MAX_RANGE
	)
	if enemies.size() == 0:
		return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_dist = a.global_position.distance_squared_to(player.global_position)
		var b_dist = b.global_position.distance_squared_to(player.global_position)
		return a_dist < b_dist
	)
	var sword_instance = sword_ability.instantiate() as SwordAbility
	var foreground_layer = get_tree().get_first_node_in_group('foreground_layer')
	foreground_layer.add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position
	sword_instance.hitbox_component.damage = base_damage * damage_percent
	var dir = player.global_position - enemies[0].global_position
	sword_instance.rotation = dir.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	match upgrade.id:
		'sword_rate':
			$Timer.wait_time = base_wait_timer * (1 - current_upgrades["sword_rate"]['quantity'] * 0.1)
			$Timer.start()
		'sword_damage':
			damage_percent = 1 + (current_upgrades["sword_damage"]['quantity'] * 0.15)
	
