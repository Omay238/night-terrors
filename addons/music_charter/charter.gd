@tool
extends EditorPlugin

var panel: Control
var player: AudioStreamPlayer
var beatline_node: Control
var rate := 128.0
var speed := 1.0

func _enter_tree():
	panel = Control.new()
	panel.name = "Charter"
	panel.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_control_to_bottom_panel(panel, "Charter")

	var vbox = VBoxContainer.new()
	panel.add_child(vbox)

	player = AudioStreamPlayer.new()
	player.bus = "Master"
	panel.add_child(player)

	beatline_node = preload("res://addons/music_charter/beat_line.gd").new()
	beatline_node.player = player
	beatline_node.rate = rate

	get_tree().get_edited_scene_root().add_child(beatline_node)

	var song_picker = EditorResourcePicker.new()
	song_picker.base_type = "AudioStream"
	song_picker.resource_changed.connect(func(res):
		player.stream = res
	)
	vbox.add_child(song_picker)

	var play_btn = Button.new()
	play_btn.text = "Start"
	play_btn.pressed.connect(func():
		if player.playing:
			player.stop()
			play_btn.text = "Start"
		else:
			player.play()
			play_btn.text = "Stop"
	)
	vbox.add_child(play_btn)

	var rate_slider = HSlider.new()
	rate_slider.min_value = 1
	rate_slider.max_value = 256
	rate_slider.value = rate
	rate_slider.value_changed.connect(func(v):
		rate = v
		beatline_node.rate = rate
	)
	vbox.add_child(rate_slider)

	var speed_slider = HSlider.new()
	speed_slider.step = 0.01
	speed_slider.min_value = 0.1
	speed_slider.max_value = 2.0
	speed_slider.value = speed
	speed_slider.value_changed.connect(func(v):
		speed = v
		player.pitch_scale = speed
	)
	vbox.add_child(speed_slider)

	set_process(true)

func _exit_tree():
	remove_control_from_bottom_panel(panel)
	panel.queue_free()
	if beatline_node and beatline_node.is_inside_tree():
		beatline_node.queue_free()
