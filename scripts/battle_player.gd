extends Node2D

var score := 0.0

func _process(delta: float) -> void:
	print(score)
	
	position.x = position.x + 128 * delta
	
	if len($perfect.get_overlapping_bodies()) > 0:
		score += 5 * delta
	elif len($good.get_overlapping_bodies()) > 0:
		score += 3 * delta
	elif len($bad.get_overlapping_bodies()) > 0:
		score += 1 * delta
	elif len($fail.get_overlapping_bodies()) > 0:
		score -= 2 * delta
	
	if Input.is_action_pressed("up"):
		position.y -= 200 * delta
	if Input.is_action_pressed("down"):
		position.y += 200 * delta
	
	if position.y < -16:
		position.y = 316
	if position.y > 316:
		position.y = -16
