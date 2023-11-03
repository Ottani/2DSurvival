extends Node
class_name HealthComponent

signal died
signal health_changed
signal health_decreased

@export var max_health: int = 10
var curr_health: int


func _ready():
	curr_health = max_health


func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	return min(curr_health as float / max_health, 1)


func damage(dmg: int):
	curr_health = max(curr_health - dmg, 0)
	health_decreased.emit()
	Callable(check_death).call_deferred()


func heal(hp: int):
	curr_health = min(curr_health + hp, max_health)
	health_changed.emit()


func check_death():
	if curr_health == 0:
		died.emit()
		owner.queue_free()
