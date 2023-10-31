extends Node

const SAVE_FILE_PATH = 'user://game.save'

var save_data: Dictionary = {
	"meta_upgrade_currency": 0,
	"meta_upgrades": {}
}


func _ready():
	GameEvents.exp_vial_collected.connect(_on_experience_collected)
	load_file()


func load_file():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		return
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	save_data = file.get_var()


func save_file():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_var(save_data)


func add_meta_upgrade(upgrade: MetaUpgrade):
	if not save_data['meta_upgrades'].has(upgrade.id):
		save_data['meta_upgrades'][upgrade.id] = {
			'quantity': 0
		}
	save_data['meta_upgrades'][upgrade.id]['quantity'] += 1
	save_data['meta_upgrade_currency'] -= upgrade.experience_cost
	save_file()


func get_meta_upgrade_quantity(id: String) -> int:
	if not save_data['meta_upgrades'].has(id):
		return 0
	return save_data['meta_upgrades'][id]['quantity']


func _on_experience_collected(number: int):
	save_data['meta_upgrade_currency'] += number

