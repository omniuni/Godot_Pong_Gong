extends Node

var sound_enabled = true

func play(time: float = 0.1, pitch: float = 1.0):
	if not sound_enabled:
		return
	if $beep.playing:
		$beep.stop()
	if time > 1.0:
		time = 1.0
	$beep.pitch_scale = pitch
	$beep.play(1.0-time)
	pass

func play_ui():
	play(0.1, 1.8)
	pass

func play_ball():
	play(0.1, 2.0)
	pass
	
func play_hit():
	play(0.07, 2.6)
	pass
	
func play_wall():
	play(0.07, 2.2)
	pass
	
func play_panel():
	play(0.07, 0.8)
	pass
	
func play_out():
	play(0.5, 0.6)
	pass
