extends CanvasLayer

signal back_pressed

@onready var window_button: Button = %WindowButton
@onready var sfx_slider: HSlider = %SfxHSlider
@onready var music_slider: HSlider = %MusicHSlider


func _ready():
	sfx_slider.value_changed.connect(_on_audio_slider_value_changed.bind('sfx'))
	music_slider.value_changed.connect(_on_audio_slider_value_changed.bind('music'))
	update_display()


func update_display():
	window_button.text = 'Fullscreen'\
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN\
		else 'Windowed'
	sfx_slider.value = get_bus_value_percent('sfx')
	music_slider.value = get_bus_value_percent('music')


func get_bus_value_percent(bus_name: String) -> float:
	var bus_idx = AudioServer.get_bus_index(bus_name)
	return db_to_linear(AudioServer.get_bus_volume_db(bus_idx))


func set_bus_value_percent(bus_name: String, value: float):
	var bus_idx = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_idx, linear_to_db(value))


func _on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_display()


func _on_audio_slider_value_changed(value: float, bus_name: String):
	set_bus_value_percent(bus_name, value)


func _on_back_button_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transition_halfway
	back_pressed.emit()
