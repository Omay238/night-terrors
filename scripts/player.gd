extends CharacterBody2D

@export var speed := 50.0
@export var sprite: AnimatedSprite2D

var step_accum := 0.0
var err := 0.0

var animation := "idle_down"

func _process(delta: float) -> void:
	# gather motion vector
	var vel := Input.get_vector("left", "right", "up", "down")
	if Global.in_battle == true:
		vel = Vector2.ZERO
	
	# animation
	var direction = animation.split("_")[1]
	var temp_anim = animation
	
	if vel.is_zero_approx():
		temp_anim = "idle_" + direction
	elif vel.x < 0:
		temp_anim = "move_left"
	elif vel.x > 0:
		temp_anim = "move_right"
	elif vel.y < 0:
		temp_anim = "move_up"
	elif vel.y > 0:
		temp_anim = "move_down"
	
	if temp_anim != animation:
		animation = temp_anim
		sprite.animation = animation
		sprite.play()
	
	# movement
	if vel == Vector2.ZERO:
		return
	
	vel = vel.normalized()
	
	step_accum += speed * delta
	
	var p := Vector2.ZERO
	
	while step_accum >= 1.0:
		step_accum -= 1.0
		var ax := absf(vel.x)
		var ay := absf(vel.y)
		
		if ax >= ay:
			p.x += sign(vel.x)
			err += ay / ax
			
			if err >= 0.5:
				p.y += sign(vel.y)
				err -= 1.0
		else:
			p.y += sign(vel.y)
			err += ax / ay
			
			if err >= 0.5:
				p.x += sign(vel.x)
				err -= 1.0
	
	move_and_collide(p)
	position = position.round()
