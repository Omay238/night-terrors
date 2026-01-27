extends Node2D

@export var enemies: int
@export var level_id: int
@export var exit: Area2D

func _ready() -> void:
	Global.remaining_enemies = enemies

func _process(_delta: float) -> void:
	if Global.remaining_enemies <= 0:
		exit.show()
		Global.level = level_id + 1
