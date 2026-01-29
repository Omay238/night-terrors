extends Sprite2D

func die():
	await get_tree().create_timer(0.1).timeout
	frame += 1
	
	if frame == 16:
		await get_tree().create_timer(1.0).timeout
		Global.in_battle = false
		get_tree().change_scene_to_file("res://scenes/room.tscn")
	else:
		die()
