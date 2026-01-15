@tool
extends RigidBody2D

var speed = 40
@export var enemy_type: EnemyType

@export_tool_button("refresh", "Reload") var refresh_action = refresh

var direction = 0

func refresh():
	$AnimatedSprite2D.sprite_frames = enemy_type.texture
	$CollisionShape2D.shape = enemy_type.collision_shape

func _ready() -> void:
	refresh()

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		freeze = Global.in_battle
		
		if enemy_type.moves and not Global.in_battle:
			if randi() % int(5000 * delta) < 1:
				direction = randi() % 4
			
			if direction == 0:
				move_and_collide(Vector2(delta * speed, 0))
			elif direction == 1:
				move_and_collide(Vector2(-delta * speed, 0))
			elif direction == 2:
				move_and_collide(Vector2(0, delta * speed))
			elif direction == 3:
				move_and_collide(Vector2(0, -delta * speed))

func _begin_combat(body: Node):
	if body == $"../Player":
		$"../Player/MainBattle".show()
		Global.op = self
		Global.in_battle = true
