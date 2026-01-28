extends Node2D

var misses := 0
var hits := 0
var p_block := -999

func _process(delta: float) -> void:
	p_block = floori(position.x / 32.0)
	position.x = position.x + 128 * delta
	
	if len($perfect.get_overlapping_bodies()) > 0 and Input.is_action_just_pressed("start") and p_block != floori(position.x / 32.0):
		hits += 2
	elif len($good.get_overlapping_bodies()) > 0 and Input.is_action_just_pressed("start") and p_block != floori(position.x / 32.0):
		hits += 1
	elif len($fail.get_overlapping_bodies()) > 0 and p_block != floori(position.x / 32.0):
		misses += 1
	
	if Input.is_action_pressed("up"):
		position.y -= 200 * delta
	if Input.is_action_pressed("down"):
		position.y += 200 * delta
	
	position.y = get_parent().get_local_mouse_position().y
	
	if position.y < -16:
		position.y = 316
	if position.y > 316:
		position.y = -16
	
	print(hits, ", ", misses)
