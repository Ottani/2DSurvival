class_name EndScreen
extends CanvasLayer

@onready var panel_container = %PanelContainer


func _ready():
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, 'scale', Vector2.ONE, 0.3)\
		.from(Vector2.ZERO).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	get_tree().paused = true
	MusicPlayer.stop()


func set_defeat():
	%TitleLabel.text = 'Defeated'
	%MessageLabel.text = 'You lost!'
	$DefeatStreamPlayer.play()


func set_victory():
	%TitleLabel.text = 'Victory'
	%MessageLabel.text = 'You won!'
	$VictoryStreamPlayer.play()


func _on_continue_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	MusicPlayer.play()
	GameEvents.change_scene.emit('res://scenes/ui/meta_menu.tscn')


func _on_quit_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	get_tree().paused = false
	GameEvents.change_scene.emit('res://scenes/ui/main_menu.tscn')
