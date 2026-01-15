extends Node2D

func _ready() -> void:
	await get_tree().create_timer(10.0).timeout
	Global.level = 0
	get_tree().change_scene_to_file("res://scenes/room.tscn")
