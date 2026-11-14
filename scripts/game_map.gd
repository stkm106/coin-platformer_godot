extends Node2D
class_name GameMap

var is_transitioning: bool = false # prevent changing camera constantly

# entrance to map2
func _on_entrance_map_2_body_entered(body: Node2D) -> void:
	if body is Stick and not is_transitioning:
		is_transitioning = true
		
		# create tween transition
		var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		# node camera, global pos for gamemap, camera pos, time for switching
		tween.tween_property($Camera2D, "global_position", Vector2(1920, 360), 0.8)
		
		# push slightly so we don't stuck near the collision
		body.velocity.x = 200 
		await tween.finished
		is_transitioning = false

# entrance back to map1
func _on_entrance_map_1_body_entered(body: Node2D) -> void:
	if body is Stick and not is_transitioning:
		is_transitioning = true
		
		# same above
		var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($Camera2D, "global_position", Vector2(640, 360), 0.8)

		body.velocity.x = -200
		await tween.finished
		is_transitioning = false
