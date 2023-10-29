extends Node

signal exp_vial_collected(number: int)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)


func emit_exp_vial_collected(number: int):
	exp_vial_collected.emit(number)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)
