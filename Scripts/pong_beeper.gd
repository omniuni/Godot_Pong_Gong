extends Node

## This script handles the common audio.
## It is autoloaded, so that it persists a single
## instance regardless of the scene.
## This is for both efficiency, and so that UI
## that changes the scene can still emit UI sounds.

func _beep(tone, time):
	if not GameSettings.Audio_Enabled:
		return
	AudioBeeper.beep_foreground(tone, time)
	pass

func play_ui():
	_beep(520, 0.05)
	pass

func play_ball():
	_beep(600, 0.1)
	pass
	
func play_hit():
	_beep(900, 0.1)
	pass
	
func play_wall():
	_beep(800, 0.1)
	pass
	
func play_panel():
	if not GameSettings.Audio_Enabled:
		return
	AudioBeeper.beep_background(400, 20.0)
	pass
	
func play_out():
	_beep(260, 0.5)
	pass
