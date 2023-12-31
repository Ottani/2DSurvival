extends CharacterBody2D

@onready var velocity_component = $VelocityComponent as VelocityComponent
@onready var visuals = $Visuals

var is_moving: bool = false


func _process(_delta):
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelarate()
	velocity_component.move(self)

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func set_is_moving(value: bool) -> void:
	is_moving = value
	

func _on_hurt_box_component_hit():
	$RandomStreamPlayer2DComponent.play_random()
