extends CharacterBody2D

signal player_died

@onready var damage_timer = $DamageTimer
@onready var health_component = $HealthComponent as HealthComponent
@onready var abilities = $Abilities
@onready var animation_player = $AnimationPlayer
@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent

var number_bodies_colliding = 0
var base_speed: float = 0

func _ready():
	base_speed = velocity_component.max_speed
	$HealthBar.value = health_component.get_health_percent()
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func _process(_delta):
	var dir = get_movement_vector().normalized()
	velocity_component.accelerate(dir)
	velocity_component.move(self)
	
	if dir.x != 0 || dir.y != 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")

	var move_sign = sign(dir.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)

func get_movement_vector() -> Vector2:
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))


func _on_collision_area_2d_body_entered(_body):
	number_bodies_colliding += 1
	check_deal_damage()


func _on_collision_area_2d_body_exited(_body):
	number_bodies_colliding -= 1


func check_deal_damage():
	if number_bodies_colliding == 0 || !damage_timer.is_stopped():
		return
	health_component.damage(1)
	damage_timer.start()


func _on_damage_timer_timeout():
	check_deal_damage()


func _on_health_component_health_changed():
	GameEvents.emit_player_damaged()
	$HealthBar.value = health_component.get_health_percent()
	$RandomStreamPlayer2DComponent.play_random()


func _on_health_component_died():
	player_died.emit()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == 'player_speed':
		velocity_component.max_speed = base_speed + (base_speed * current_upgrades['player_speed']['quantity'] * 0.1)
	elif upgrade.ability_controller_scene != null:
		abilities.add_child(upgrade.ability_controller_scene.instantiate())

