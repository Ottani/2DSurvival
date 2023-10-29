extends CanvasLayer

@export var arena_timer_manager: Node
@onready var label = $%Label as Label

func _process(_delta):
	if arena_timer_manager == null:
		return
	var time_elapsed = arena_timer_manager.get_time_elapsed()
	label.text = format_time(time_elapsed)
	
func format_time(seconds: float):
	var minutes = floor(seconds / 60)
	var rem_seconds = seconds - (minutes * 60)
	return str(minutes) + ':' + ('%02d' % floor(rem_seconds))
