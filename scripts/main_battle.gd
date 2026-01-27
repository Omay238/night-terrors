extends Node2D

func _rhythm():
	$"../Camera2D".enabled = false
	add_child(Global.op.enemy_type.song.instantiate())
	$Attack.disabled = true
	$Rhythm/Rhythm.global_position.y = -100000
	$Rhythm/Rhythm/BattlePlayer/Camera2D.limit_top = -99850
	$Rhythm/Rhythm/BattlePlayer/Camera2D.limit_bottom = -99850
	await $Rhythm/Rhythm/AudioStreamPlayer2D.finished
	await get_tree().create_timer(1).timeout
	$Rhythm.queue_free()
	Global.op.queue_free()
	Global.in_battle = false
	hide()
	$"../Camera2D".enabled = true
	Global.remaining_enemies -= 1
