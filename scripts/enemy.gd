@tool
extends RigidBody2D

var speed = 40
@export var enemy_type: EnemyType

@export_tool_button("refresh", "Reload") var refresh_action = refresh

var direction = 9999

func refresh():
	$AnimatedSprite2D.sprite_frames = enemy_type.texture
	$CollisionShape2D.shape = enemy_type.collision_shape
	$Area2D/CollisionShape2D.shape = enemy_type.detection_shape

func _ready() -> void:
	refresh()

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		freeze = Global.in_battle
		
		if enemy_type.moves and not Global.in_battle:
			if randi() % maxi(int(5000 * delta), 1) < 1:
				direction = randi() % 6
			
			var temp_anim = ""
			
			if direction == 0:
				move_and_collide(Vector2(delta * speed, 0))
				temp_anim = "move_right"
			elif direction == 1:
				move_and_collide(Vector2(-delta * speed, 0))
				temp_anim = "move_left"
			elif direction == 2:
				move_and_collide(Vector2(0, delta * speed))
				temp_anim = "move_down"
			elif direction == 3:
				move_and_collide(Vector2(0, -delta * speed))
				temp_anim = "move_up"
			else:
				temp_anim = "idle"
			
			if temp_anim != $AnimatedSprite2D.animation:
				$AnimatedSprite2D.animation = temp_anim
				$AnimatedSprite2D.play()

func _begin_combat(body: Node):
	if body == $"../Player":
		$"../Player/MainBattle".show()
		$"../Player/MainBattle/Attack".disabled = false
		Global.op = self
		Global.in_battle = true
