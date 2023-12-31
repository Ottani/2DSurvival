extends Node

@export var upgrade_screen_scene: PackedScene

var upgrade_pool: WeightedTable = WeightedTable.new()
var current_upgrades = {}

var upgrade_axe = preload("res://resources/upgrades/axe.tres") as AbilityUpgrade
var upgrade_axe_damage =  preload("res://resources/upgrades/axe_damage.tres") as AbilityUpgrade
var upgrade_sword_rate = preload("res://resources/upgrades/sword_rate.tres") as AbilityUpgrade
var upgrade_sword_damage = preload("res://resources/upgrades/sword_damage.tres") as AbilityUpgrade
var upgrade_player_speed = preload("res://resources/upgrades/player_speed.tres") as AbilityUpgrade
var upgrade_anvil = preload('res://resources/upgrades/anvil.tres') as AbilityUpgrade
var upgrade_anvil_quantity = preload('res://resources/upgrades/anvil_quantity.tres') as AbilityUpgrade


func _ready():
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_anvil, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	upgrade_pool.add_item(upgrade_player_speed, 5)


func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if not has_upgrade:
		current_upgrades[upgrade.id] = {
			'reference': upgrade,
			'quantity': 1
		}
	else:
		current_upgrades[upgrade.id]['quantity'] += 1
		
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]['quantity']
		if current_quantity >= upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)
		
	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)
	elif chosen_upgrade.id == upgrade_anvil.id:
		upgrade_pool.add_item(upgrade_anvil_quantity, 5)


func pick_upgrades() -> Array[AbilityUpgrade]:
	var chosen_upgrades: Array[AbilityUpgrade] = []
	
	for i in 2:
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades) as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)

	return chosen_upgrades


func _on_experience_manager_level_up(_new_level):
	var chosen_upgrades = pick_upgrades();
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades)
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


