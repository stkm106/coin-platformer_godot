extends CanvasLayer
class_name HUD

@onready var coin_label: Label = $CoinLabel

func _process(_delta: float) -> void:
	coin_label.text = "Coins: " + str(GameManager.score)
