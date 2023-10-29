extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var experience_vial = $ExperienceVial


func _on_area_2d_area_entered(_area):
	Callable(func(): collision_shape_2d.disabled = true).call_deferred()
	play_sound()
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, 0.7)\
		.set_ease(Tween.EASE_IN)
		#.set_trans(Tween.TRANS_BACK)
	tween.tween_property(experience_vial, 'scale', Vector2.ZERO, 0.1).set_delay(0.6)
	tween.chain()
	tween.tween_callback(collect)


func tween_collect(percent: float, start_position: Vector2):
	var player = get_tree().get_first_node_in_group('player')
	if player == null:
		return
	global_position = start_position.lerp(player.global_position, percent)
	var target_rotation = (player.global_position - start_position).angle() + PI / 2
	rotation = lerp_angle(rotation, target_rotation, percent)


func collect():
	GameEvents.emit_exp_vial_collected(1)
	queue_free()


func play_sound():
	$RandomStreamPlayer2DComponent.play_random()

