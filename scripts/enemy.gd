extends Sprite2D

func _ready() -> void:
	$Area2D.body_entered.connect(_begin_combat)

func _begin_combat(body: Node2D):
	if body == $"../Player":
		Global.in_battle = true
		$"../Player/MainBattle".show()
