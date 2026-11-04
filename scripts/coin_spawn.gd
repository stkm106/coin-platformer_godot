extends Node2D

@export var coin_scene: PackedScene 
@export_range(0.0, 1.0) var bad_coin_chance: float = 0.3
@export var max_coins: int = 3
@export var cooldown: float = 1.0
@onready var spawn_points_container = $SpawnPoints

var last_spawn_point: Node2D = null 

func _ready():
	for i in range(max_coins):
		spawn_one_coin()

func spawn_one_coin():
	if cooldown > 0:
		await get_tree().create_timer(cooldown).timeout
		
	if coin_scene == null:
		return
	
	# get Marker2D positions
	var spawn_points = spawn_points_container.get_children()
	if spawn_points.is_empty():
		return

	# check existing pos
	var valid_points = []
	for pt in spawn_points:
		var is_occupied = false
		
		# check if there are coins in these marker pos
		for child in get_children():
			if child is Coin and child.global_position == pt.global_position:
				is_occupied = true
				break
		
		if not is_occupied and pt != last_spawn_point:
			valid_points.append(pt)
	
	# choose random pos after all the checking
	var chosen_marker = spawn_points.pick_random() if valid_points.is_empty() else valid_points.pick_random()
	last_spawn_point = chosen_marker
	
	# put coins in chosen pos
	var new_coin = coin_scene.instantiate() as Coin
	new_coin.global_position = chosen_marker.global_position
	
	new_coin.coin_respawn.connect(spawn_one_coin)
	
	# if rng < chance (30%), spawn red coin, otherwise gold coin
	if randf() < bad_coin_chance:
		new_coin.set_coin_type(new_coin.CoinType.BAD)
	else:
		new_coin.set_coin_type(new_coin.CoinType.GOOD)
		
	add_child(new_coin)
