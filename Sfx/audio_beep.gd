class_name AudioBeep

var _tone_hz: float = 440.0
var _sample_rate: float = 0
var frames_left: int = 0

var phase: float = 0.0

var increment: float = 0:
	get:
		return _tone_hz / _sample_rate

func _init(tone_hz: float, time_in_seconds: float, sample_rate: int = 11025) -> void:
	update(tone_hz, time_in_seconds, sample_rate)
	pass
	
func update(tone_hz: float, time_in_seconds: float, sample_rate: int = 11025) -> void:
	_tone_hz = tone_hz
	_sample_rate = sample_rate
	frames_left = int(time_in_seconds * sample_rate)
	pass
