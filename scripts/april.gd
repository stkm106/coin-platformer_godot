extends Area2D
class_name April

@export var fly_speed: float = 80.0
var stick: Node2D = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	await get_tree().process_frame
	stick = get_tree().get_first_node_in_group("stick")

func _physics_process(delta: float) -> void:
	if stick and is_instance_valid(stick):
		# move straight to stick pos
		global_position = global_position.move_toward(stick.global_position, fly_speed * delta)
		rotation += 3.0 * delta # add spinning
		print("tọa độ April: ", global_position)
		
func _on_body_entered(body: Node2D) -> void:
	if body is Stick:
		GameManager.score = 0
		get_tree().call_deferred("reload_current_scene") # for april to reload main_game
