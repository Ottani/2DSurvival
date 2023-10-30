extends Node

signal arena_difficulty_increased(arena_difficulty: int)

const DIFFICULTY_INTERVAL = 5

const end_screen_scene = preload("res://scenes/ui/end_screen.tscn")

@onready var timer = $Timer as Timer

var arena_difficulty: int = 0


func _process(_delta):
	var next_time_target = timer.wait_time - ((arena_difficulty + 1) * DIFFICULTY_INTERVAL)
	if timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)
		print('arena difficulty: ' + str(arena_difficulty))


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left


func _on_timer_timeout():
	if end_screen_scene != null:
		var end_screen_instance = end_screen_scene.instantiate() as EndScreen
		add_child(end_screen_instance)
		end_screen_instance.set_victory()
		MetaProgression.save_file()
