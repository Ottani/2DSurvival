extends Node

const end_screen_scene = preload("res://scenes/ui/end_screen.tscn")
const pause_scene = preload('res://scenes/ui/pause_menu.tscn')

func _ready():
	Globals.reset_enemies()


func _on_player_player_died():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	MetaProgression.save_file()


func _unhandled_key_input(event):
	if event.is_action_pressed('pause'):
		add_child(pause_scene.instantiate())
		get_tree().root.set_input_as_handled()
