extends Node2D

const MAX_RADIUS = 100.0

@onready var hitbox_component = $HitBoxComponent

var base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))

var player = null

func _ready():
	player = get_tree().get_first_node_in_group('player')
	if player == null:
		return

	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, 2.0, 3)
	tween.tween_callback(queue_free)


func tween_method(value: float):
	var radius = (value / 2) * MAX_RADIUS
	var direction = base_rotation.rotated(value * TAU)
	global_position = player.global_position + (direction * radius)
