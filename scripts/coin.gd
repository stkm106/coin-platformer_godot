extends Area2D
class_name Coin

signal coin_respawn
enum CoinType { GOOD, BAD }
var type: CoinType = CoinType.GOOD
@onready var coin_sprite: AnimatedSprite2D = $CoinSprite

# lifetime duration of a coin
func _ready():
	var lifetime: float = randf_range(3.0, 5.0)
	var timer: SceneTreeTimer = get_tree().create_timer(lifetime)
	timer.timeout.connect(_on_lifetime_timeout)

func set_coin_type(new_type: CoinType):
	type = new_type
	if not is_node_ready():
		await ready
		
	if type == CoinType.GOOD:
		coin_sprite.play("goodcoin")
	else:
		coin_sprite.play("badcoin")

# wait until lifetime timeout, then respawn and free queue
func _on_lifetime_timeout():
	coin_respawn.emit()
	call_deferred("queue_free")

func _on_body_entered(body: Node2D):
	if body is Stick:
		if type == CoinType.GOOD:
			coin_respawn.emit()
			call_deferred("queue_free") # for gold coin to be collected
		else:
			get_tree().call_deferred("reload_current_scene") # for red coin to reload main_game
