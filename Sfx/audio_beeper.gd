extends Node

@onready var _beeper_bg: AudioStreamPlayer = $beeper_bg
@onready var _beeper_fg: AudioStreamPlayer = $beeper_fg

var _beep_bg: AudioBeep
var _beep_fg: AudioBeep

func _process(delta: float) -> void:
	
	if _beeper_bg.playing:
		_generate(_beeper_bg, _beep_bg)
		
	if _beeper_fg.playing:
		_generate(_beeper_fg, _beep_fg)
	
	pass
	
func _generate(player: AudioStreamPlayer, beep: AudioBeep):
	var playback: AudioStreamGeneratorPlayback = player.get_stream_playback()
	var frames_available: int = playback.get_frames_available()
	for i in range(frames_available):
		var frame_value: Vector2 = Vector2.ONE * sin(beep.phase * TAU)
		playback.push_frame(frame_value)
		beep.phase = fmod(beep.phase + beep.increment, 1.0)
	if beep.frames_left(frames_available) <= 0:
		player.stop()
	pass
	
func beep_background(tone_hz: float, time_in_seconds: float):
	if not _beeper_bg.playing:
		_beeper_bg.play()
	_beep_bg = AudioBeep.new(tone_hz, time_in_seconds, _beeper_bg.stream.mix_rate)
	pass
	
func beep_foreground(tone_hz: float, time_in_seconds: float):
	if not _beeper_fg.playing:
		_beeper_fg.play()
	_beep_fg = AudioBeep.new(tone_hz, time_in_seconds, _beeper_fg.stream.mix_rate)
	pass
