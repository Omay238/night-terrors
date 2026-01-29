extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body == $"../Player" and Global.remaining_enemies <= 0:
		Global.in_battle = true
		await get_tree().create_timer(1).timeout
		get_tree().call_deferred("change_scene_to_file", "res://scenes/room.tscn")
