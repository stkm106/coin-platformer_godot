extends Node

signal april_1 # 20 coin
signal april_2 # 50 coin
signal april_3 # 70 coin
signal game_won

var score: int = 0:
	set(value):
		score = value
		_check_score()

func _check_score() -> void:
	if score == 20:
		april_1.emit()
	elif score == 50:
		april_2.emit()
	elif score == 70:
		april_3.emit()
	elif score == 106:
		game_won.emit()
