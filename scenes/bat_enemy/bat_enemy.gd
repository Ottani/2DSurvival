extends CharacterBody2D

@onready var velocity_component = $VelocityComponent as VelocityComponent
@onready var visuals = $Visuals

func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func _on_hurt_box_component_hit():
	$RandomStreamPlayer2DComponent.play_random()
	move_and_slide()
