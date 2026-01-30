extends Node2D

var misses := 0
var hits := 0
var p_block := -999
var camera_pos := -99850
var started = false
var last_ouch = -1000

func _ready():
	await get_tree().create_timer(1.0).timeout
	started = true
	$"../AudioStreamPlayer2D".play()

func _process(delta: float) -> void:
	if started:
		p_block = floori(position.x / 32.0)
		var p_misses = misses
		var p_hits = hits
		position.x = position.x + 128 * delta * get_parent().jank_bpm
		
		if Input.is_action_pressed("start"):
			$Sprite2D.frame = 1
		else:
			$Sprite2D.frame = 0
		
		if Input.is_action_just_pressed("start"):
			var found_note = false
			
			for body in $perfect.get_overlapping_bodies():
				if not body.is_hit:
					found_note = true
					body.is_hit = true
					hits += 1
			
			if found_note == false and Time.get_ticks_msec() - last_ouch >= 1000:
				misses += 1
		
		for body in $fail.get_overlapping_bodies():
			if not body.is_hit:
				body.is_hit = true
				if Time.get_ticks_msec() - last_ouch >= 1000:
					misses += 1
		
		if p_misses != misses:
			last_ouch = Time.get_ticks_msec()
			$Camera2D/Whack.show()
			$Camera2D/Whack.play()
		
		if p_hits != hits:
			$Camera2D/Lesterful.show()
			$Camera2D/Lesterful.play()
		
		#if Input.is_action_pressed("up"):
			#position.y -= 200 * delta
		#if Input.is_action_pressed("down"):
			#position.y += 200 * delta
		
		#if position.y < -16:
			#position.y = 316
		#if position.y > 316:
			#position.y = -16
		
		$Camera2D/Health.frame = misses
		
		if misses >= 6:
			misses = 0
			$Camera2D/Health.frame = 6
			$Camera2D/Health.die()
			get_tree().paused = true
	
	position.y = get_parent().get_local_mouse_position().y
	$Camera2D.global_position.y = camera_pos
