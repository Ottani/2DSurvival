extends Node

signal enemy_quantity_changed(quantity: int)

var _enemy_quantity = 0


func add_enemy(qty: int) -> void:
	_enemy_quantity += qty
	enemy_quantity_changed.emit(_enemy_quantity)


func del_enemy(qty: int = 1) -> void:
	_enemy_quantity -= qty
	enemy_quantity_changed.emit(_enemy_quantity)
