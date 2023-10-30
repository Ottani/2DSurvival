extends CanvasLayer

@onready var panel_container = %PanelContainer

var options_scene: PackedScene = preload('res://scenes/ui/options_menu.tscn')
var is_closing: bool = false

func _ready():
	get_tree().paused = true
	$AnimationPlayer.play('default')
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, 'scale', Vector2.ONE, 0.3).from(Vector2.ZERO)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)


func _unhandled_key_input(event):
	if event.is_action_pressed('pause'):
		close()
		get_tree().root.set_input_as_handled()


func close():
	if is_closing:
		return
	is_closing = true
	$AnimationPlayer.play_backwards('default')
	var tween = create_tween()
	tween.tween_property(panel_container, 'scale', Vector2.ZERO, 0.3).from(Vector2.ONE)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	await tween.finished
	get_tree().paused = false
	queue_free()


func _on_resume_button_pressed():
	close()


func _on_options_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_quit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file('res://scenes/ui/main_menu.tscn')


func _on_options_closed(scene: Node):
	scene.queue_free()
