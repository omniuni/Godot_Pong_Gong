extends Node

var _beeper_player: AudioStreamPlayer = AudioStreamPlayer.new()
var _beeper_generator: AudioStreamGenerator = AudioStreamGenerator.new()

var _beep_bg: AudioBeep = AudioBeep.new(320, 0)
var _beep_fg: AudioBeep = AudioBeep.new(440, 0)

func _ready() -> void:
	print_debug("Setting up audio generator...")
	_beeper_generator.mix_rate = 7350
	_beeper_generator.buffer_length = 0.032
	_beeper_player.stream = _beeper_generator
	_beeper_player.autoplay = true
	add_child(_beeper_player, false, Node.INTERNAL_MODE_BACK)
	print_debug("Audio Generator has been initialized.")
	pass

func _process(delta: float) -> void:
	
	if _beeper_player.playing:
		var beeps_array: Array[AudioBeep] = [_beep_bg, _beep_fg]
		var should_play: bool = false
		for beep in beeps_array:
			if beep.frames_left > 0:
				should_play = true
		if should_play:
			_generate(_beeper_player, [_beep_fg, _beep_bg])
	
	pass
	
func _generate(player: AudioStreamPlayer, beeps: Array[AudioBeep]):
	var playback: AudioStreamGeneratorPlayback = player.get_stream_playback()
	var frames_available: int = playback.get_frames_available()
	var highest_frames_left = 0
	for beep in beeps:
		if beep.frames_left > highest_frames_left:
			highest_frames_left = beep.frames_left
	
	for i in range(frames_available):
		if highest_frames_left > 0:
			for beep in beeps:
				beep.phase = fmod(beep.phase + beep.increment, 1.0)
				beep.frames_left-=1
			var frame_compute_sum: Vector2 = Vector2(0,0)
			var frame_sum_count: int = 0
			for beep in beeps:
				if beep.frames_left > 0:
					frame_compute_sum += Vector2.ONE * sin(beep.phase * TAU)
					frame_sum_count += 1
			var frame_value: Vector2 = frame_compute_sum/frame_sum_count
			playback.push_frame(frame_value)
		else:
			playback.push_frame(Vector2.ZERO)
			
	pass
	
func beep_background(tone_hz: float, time_in_seconds: float):
	_beep_bg.update(tone_hz, time_in_seconds, _beeper_player.stream.mix_rate)
	pass
	
func beep_foreground(tone_hz: float, time_in_seconds: float):
	_beep_fg.update(tone_hz, time_in_seconds, _beeper_player.stream.mix_rate)
	pass
