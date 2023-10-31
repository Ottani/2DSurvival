extends CanvasLayer

signal transition_halfway


func transition():
	$AnimationPlayer.play('default')
	await $AnimationPlayer.animation_finished
	transition_halfway.emit()
	$AnimationPlayer.play_backwards('default')


func transition_to_scene(scene_path: String):
	transition()
	await transition_halfway
	get_tree().change_scene_to_file(scene_path)
