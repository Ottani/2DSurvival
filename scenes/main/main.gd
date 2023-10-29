extends Node

const end_screen_scene = preload("res://scenes/ui/end_screen.tscn")


func _on_player_player_died():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
	end_screen_instance.set_defeat()
	

