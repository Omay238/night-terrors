extends Node2D

@export var levels: Array[PackedScene]

func _ready() -> void:
	get_tree().change_scene_to_packed(levels[Global.level])
