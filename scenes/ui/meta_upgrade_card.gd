extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel
@onready var progress_bar = %ProgressBar
@onready var purchase_button = %PurchaseButton
@onready var progress_label = %ProgressLabel
@onready var count_label = %CountLabel

var _upgrade: MetaUpgrade

func set_meta_upgrade(upgrade: MetaUpgrade):
	_upgrade = upgrade
	name_label.text = upgrade.title
	description_label.text = upgrade.description
	upgrade_progress()


func upgrade_progress():
	var currency = MetaProgression.save_data['meta_upgrade_currency']
	progress_bar.value = min(currency as float / _upgrade.experience_cost, 1.0)
	progress_label.text = str(currency) + '/' + str(_upgrade.experience_cost)
	var current_quantity = MetaProgression.get_meta_upgrade_quantity(_upgrade.id)
	var maxed = current_quantity >= _upgrade.max_quantity
	purchase_button.disabled = progress_bar.value < 1 or maxed
	purchase_button.text = 'Maxed' if maxed else 'Purchase'
	count_label.text = 'x%d' % current_quantity


func _on_purchase_button_pressed():
	if _upgrade != null:
		MetaProgression.add_meta_upgrade(_upgrade)
		get_tree().call_group('meta_upgrade_card', 'upgrade_progress')
		$AnimationPlayer.play('selected')

