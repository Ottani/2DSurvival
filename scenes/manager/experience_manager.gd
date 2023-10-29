extends Node
class_name ExperienceManager

signal exp_updated(curr_exp: int, target_exp: int)
signal level_up(new_level: int)

const TARGET_EXP_GROWTH = 5

var curr_exp: int = 0
var curr_lvl: int = 1
var target_exp: int = 1


func _ready():
	GameEvents.exp_vial_collected.connect(on_exp_vial_collected)


func on_exp_vial_collected(number: int):
	curr_exp += number
	if (curr_exp >= target_exp):
		curr_lvl += 1
		target_exp += TARGET_EXP_GROWTH
		curr_exp = 0
		level_up.emit(curr_lvl)
	exp_updated.emit(curr_exp, target_exp)

