extends Node

signal april_1 # 20 coin
signal april_2 # 50 coin
signal april_3 # 70 coin
signal game_won
const april = preload("uid://cdutyi0iolur8") # scene id

var score: int = 0:
	set(value):
		score = value
		_check_score()
		
func _ready() -> void:
	april_1.connect(_spawn_april)
	april_2.connect(_spawn_april)
	april_3.connect(_spawn_april)
		
func _check_score() -> void:
	if score == 5:
		april_1.emit()
	elif score == 10:
		april_2.emit()
	elif score == 70:
		april_3.emit()
	elif score == 106:
		game_won.emit()
		
func _spawn_april() -> void:
	var april_instance = april.instantiate()
	april_instance.global_position = Vector2(1950, 300) # spawn pos
	get_tree().current_scene.call_deferred("add_child", april_instance) # call lil cuh
	print("April xuất hiện")
