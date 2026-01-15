@tool
extends Control

@export var player: AudioStreamPlayer
@export var rate := 128.0

func _process(_delta):
	if player and player.playing:
		queue_redraw()

func _draw():
	if not player or not player.playing:
		return

	var x = player.get_playback_position() * rate
	var size = get_viewport_rect().size
	draw_line(Vector2(x, 0), Vector2(x, size.y), Color.RED, 2)
