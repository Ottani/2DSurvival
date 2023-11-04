extends CanvasLayer

@export var arena_timer_manager: Node

@onready var fps_label = %FPSLabel as Label
@onready var timer_label = %TimerLabel as Label
@onready var enemies_label = %EnemiesLabel as Label


func _ready():
	Globals.enemy_quantity_changed.connect(_on_enemy_qty_changed)


func _process(_delta):
	fps_label.set_text("FPS: %d" % Engine.get_frames_per_second())
	if arena_timer_manager == null:
		return
	var time_elapsed = arena_timer_manager.get_time_elapsed()
	timer_label.text = format_time(time_elapsed)


func format_time(seconds: float):
	var minutes = floor(seconds / 60)
	var rem_seconds = seconds - (minutes * 60)
	return str(minutes) + ':' + ('%02d' % floor(rem_seconds))


func _on_enemy_qty_changed(qty: int):
	enemies_label.set_text("Enemies: %d" % qty)
