extends Area2D
class_name HurtBoxComponent

@export var health_component: HealthComponent
var floating_text_scene: PackedScene = preload("res://scenes/ui/floating_text.tscn")


func _on_area_entered(area: Area2D):
	if health_component == null or not area is HitBoxComponent:
		return
	health_component.damage(area.damage)

	var floating_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group('foreground_layer').add_child(floating_text)
	floating_text.global_position = global_position + Vector2.UP * 16
	
	floating_text.start(str(snapped(area.damage, 0.1)))
