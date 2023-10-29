extends CanvasLayer
class_name EndScreen

func _ready():
	get_tree().paused = true


func set_defeat():
	%TitleLabel.text = 'Defeated'
	%MessageLabel.text = 'You lost!'


func set_victory():
	%TitleLabel.text = 'Victory'
	%MessageLabel.text = 'You won!'


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
