@tool
extends Node2D

var is_hit := false

@export_range(0, 1000000) var time: int:
	set(value):
		time = value
		position.x = 32 * time - 16

@export_range(0, 8, 1, "prefer_slider") var line: int:
	set(value):
		line = value
		position.y = 32 * line + 16

@export_range(0, 1000000) var duration: int:
	set(value):
		duration = value
		if duration == 0:
			$NinePatchRect.hide()
			$Sprite2D.show()
		else:
			$Sprite2D.hide()
			$NinePatchRect.show()
			$NinePatchRect.size.x = duration * 32 + 32

func _ready() -> void:
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.size.x = duration * 32 + 32
	$CollisionShape2D.shape.size.y = 32
	$CollisionShape2D.position.x = duration * 16
