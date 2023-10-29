extends Node

@export var axe_ability_scene: PackedScene

var base_damage = 10.0
var damage_percent = 1.0


func _ready():
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func _on_timer_timeout():
	var player = get_tree().get_first_node_in_group('player') as Node2D
	if player == null:
		return

	var foreground_layer = get_tree().get_first_node_in_group('foreground_layer') as Node2D
	if foreground_layer == null:
		return
	
	var axe_instance = axe_ability_scene.instantiate() as Node2D
	foreground_layer.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	axe_instance.hitbox_component.damage = base_damage * damage_percent


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	match upgrade.id:
		'axe_damage':
			damage_percent = 1.0 + (current_upgrades["axe_damage"]['quantity'] * 0.1)

