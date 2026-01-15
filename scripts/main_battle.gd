extends Node2D

func _rhythm():
	$"../Camera2D".enabled = false
	add_child(preload("res://scenes/battle/rhythm.tscn").instantiate())
	$Rhythm.position.y = -1000
	$Rhythm/BattlePlayer/Camera2D.limit_top = -700
	$Rhythm/BattlePlayer/Camera2D.limit_bottom = -700
	await $Rhythm/AudioStreamPlayer2D.finished
	await get_tree().create_timer(3).timeout
	$Rhythm.queue_free()
	Global.in_battle = false
	Global.op.queue_free()
	$"../Camera2D".enabled = true
	Global.level += 1
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
