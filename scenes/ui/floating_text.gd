extends Node2D


func start(text: String, is_crit: bool = false):
	$Label.text = text
	var max_scale = Vector2(1.5, 1.5)
	if is_crit:
		$Label.add_theme_color_override("font_color", Color.ORANGE)
		$Label.z_index = 3
		max_scale = Vector2(1.75, 1.75)
	
	var tween = create_tween()
	tween.tween_property(self, 'global_position', global_position + Vector2.UP * 16, 0.3)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, 'global_position', global_position + Vector2.UP * 48, 0.5)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(queue_free)

	var scale_tween = create_tween()
	scale_tween.tween_property(self, 'scale', max_scale, 0.15)\
		.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self, 'scale', Vector2.ONE, 0.15)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self, 'scale', Vector2.ZERO, 0.5)\
		.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
