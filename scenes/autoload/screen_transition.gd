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
	GameEvents.change_scene.emit(scene_path)
