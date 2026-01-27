extends Node2D

@export var levels: Array[PackedScene]
@export var level_selectors: Array[Sprite2D]

var selected_level = Global.level
var p_level = 0

func _ready() -> void:
	for sel in range(len(level_selectors)):
		if sel == selected_level:
			level_selectors[sel].rotation = 0
		else:
			level_selectors[sel].rotation = PI

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("start"):
		get_tree().change_scene_to_packed(levels[selected_level])
	
	p_level = selected_level
	if Input.is_action_just_pressed("left"):
		selected_level = selected_level - 1
		if selected_level == -1:
			selected_level = len(level_selectors) - 1
		
		var tween = get_tree().create_tween().set_parallel(true)
		
		level_selectors[selected_level].rotation = deg_to_rad(150)
		tween.tween_property(level_selectors[selected_level], "rotation", 0, 0.5).set_ease(Tween.EASE_IN_OUT)
		
		level_selectors[p_level].rotation = 0
		tween.tween_property(level_selectors[p_level], "rotation", deg_to_rad(-120), 0.5).set_ease(Tween.EASE_OUT_IN)
	elif Input.is_action_just_pressed("right"):
		selected_level = selected_level + 1
		if selected_level == len(level_selectors):
			selected_level = 0
		
		var tween = get_tree().create_tween().set_parallel(true)
		
		level_selectors[selected_level].rotation = deg_to_rad(-120)
		tween.tween_property(level_selectors[selected_level], "rotation", 0, 0.5).set_ease(Tween.EASE_IN_OUT)
		
		level_selectors[p_level].rotation = 0
		tween.tween_property(level_selectors[p_level], "rotation", deg_to_rad(150), 0.5).set_ease(Tween.EASE_IN_OUT)
