@tool
extends Sprite2D

@export var enemy_type: EnemyType

@export_tool_button("refresh", "Reload") var refresh_action = refresh

func refresh():
	texture = enemy_type.texture
	$Area2D/CollisionShape2D.shape = enemy_type.collision_shape

func _ready() -> void:
	refresh()

func _begin_combat(body: Node2D):
	if body == $"../Player":
		$"../Player/MainBattle".show()
		Global.in_battle = true
