extends Node2D

var misses := 0
var hits := 0
var p_block := -999

func _process(delta: float) -> void:
	p_block = floori(position.x / 32.0)
	position.x = position.x + 128 * delta
	
	if Input.is_action_just_pressed("start"):
		for body in $perfect.get_overlapping_bodies():
			if not body.is_hit:
				body.is_hit = true
				hits += 2
		
		for body in $good.get_overlapping_bodies():
			if not body.is_hit:
				body.is_hit = true
				hits += 1
	
	for body in $fail.get_overlapping_bodies():
		if not body.is_hit:
			body.is_hit = true
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
