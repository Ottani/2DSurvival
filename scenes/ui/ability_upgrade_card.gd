extends PanelContainer

signal selected

@onready var name_label: Label = %NameLabel
@onready var description_label: Label = %DescriptionLabel

var disabled: bool = false

func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func select_card():
	disabled = true
	$AnimationPlayer.play('selected')
	for other_card in get_tree().get_nodes_in_group('upgrade_card'):
		if other_card != self:
			other_card.play_discard()
	
	await $AnimationPlayer.animation_finished
	selected.emit()


func _on_gui_input(event: InputEvent):
	if not disabled and event.is_action_pressed("left_click"):
		select_card()


func play_in(delay: float = 0):
	modulate = Color.TRANSPARENT
	await get_tree().create_timer(delay).timeout
	modulate = Color.WHITE
	$AnimationPlayer.play('in')


func play_discard():
	$AnimationPlayer.play('discard')


func _on_mouse_entered():
	if not disabled:
		$HoverAnimationPlayer.play('hover')
