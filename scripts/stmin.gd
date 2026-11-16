extends Area2D
class_name Stmin

@onready var talk: RichTextLabel = $RichTextLabel

func _ready() -> void:
	talk.visible = false

func _on_body_entered(body: Node2D) -> void:
	if body is Stick:
		talk.visible = true
		_dialouge()
		
func _on_body_exited(body: Node2D) -> void:
	if body is Stick:
		talk.visible = false
		
func _dialouge():
	var current_score = GameManager.score
	if current_score < 20:
		talk.text = "Hey, you're gonna have some fun when you get 20 coins."
	elif current_score < 50:
		talk.text = "Careful at 50 coins, it's not safe for sure."
	elif current_score < 70:
		talk.text = "Try getting 70 coins now, have fun surviving."
	elif current_score < 106:
		talk.text = "Keep going. 106 coins is winning."
	else:
		talk.text = "Congrats, that was great."
	
