extends Node

func _ready() -> void:
	$Button.button_down.connect(_bedroom)

func _bedroom() -> void:
	get_tree().change_scene_to_file("res://scenes/room.tscn")
