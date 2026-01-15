extends Sprite2D

var player_in = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("start") and player_in:
		get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _enable_label(body: Node2D):
	if body == $"../Player":
		$"../Label".show()
		player_in = true

func _disable_label(body: Node2D):
	if body == $"../Player":
		$"../Label".hide()
		player_in = false
