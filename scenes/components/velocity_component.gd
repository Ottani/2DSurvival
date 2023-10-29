class_name VelocityComponent
extends Node


@export var max_speed: float = 40.0
@export var acceleration: float = 5.0

var velocity = Vector2.ZERO


func accelerate_to_player():
	var owner_node = owner as Node2D
	if owner_node == null:
		return
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node == null:
		return
	var direction = (player_node.global_position - owner_node.global_position).normalized()
	accelerate(direction)


func accelerate(direction: Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))
	

func decelarate():
	accelerate(Vector2.ZERO)


func move(character: CharacterBody2D):
	character.velocity = velocity
	character.move_and_slide()
	velocity = character.velocity
	
