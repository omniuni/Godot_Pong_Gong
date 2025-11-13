extends Node

@onready var _beeper_bg: AudioStreamPlayer = $beeper_bg
@onready var _beeper_fg: AudioStreamPlayer = $beeper_fg

var _beep_bg: AudioBeep = AudioBeep.new(320, 0)
var _beep_fg: AudioBeep = AudioBeep.new(440, 0)

func _process(delta: float) -> void:
	
	if _beep_bg.frames_left > 0:
		_generate(_beeper_bg, _beep_bg)
		
	if _beep_fg.frames_left > 0:
		_generate(_beeper_fg, _beep_fg)
	
	pass
	
func _generate(player: AudioStreamPlayer, beep: AudioBeep):
	if not player.playing:
		player.play()
	var playback: AudioStreamGeneratorPlayback = player.get_stream_playback()
	var frames_available: int = playback.get_frames_available()
	for i in range(frames_available):
		if beep.frames_left > 0:
			var frame_value: Vector2 = Vector2.ONE * sin(beep.phase * TAU)
			playback.push_frame(frame_value)
			beep.phase = fmod(beep.phase + beep.increment, 1.0)
			beep.frames_left-=1
	pass
	
func beep_background(tone_hz: float, time_in_seconds: float):
	_beep_bg.update(tone_hz, time_in_seconds, _beeper_bg.stream.mix_rate)
	pass
	
func beep_foreground(tone_hz: float, time_in_seconds: float):
	_beep_fg.update(tone_hz, time_in_seconds, _beeper_fg.stream.mix_rate)
	pass
