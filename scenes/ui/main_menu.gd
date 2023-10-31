extends CanvasLayer

var options_scene: PackedScene = preload('res://scenes/ui/options_menu.tscn')


func _on_play_button_pressed():
	ScreenTransition.transition_to_scene("res://scenes/main/main.tscn")


func _on_options_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(_on_options_closed.bind(options_instance))


func _on_quit_button_pressed():
	get_tree().quit()


func _on_options_closed(scene: Node):
	scene.queue_free()


func _on_meta_button_pressed():
	ScreenTransition.transition_to_scene("res://scenes/ui/meta_menu.tscn")

