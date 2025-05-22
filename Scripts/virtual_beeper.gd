extends Node

## This script handles the common audio.
## It is autoloaded, so that it persists a single
## instance regardless of the scene.
## This is for both efficiency, and so that UI
## that changes the scene can still emit UI sounds.

@onready
var beep: AudioStreamPlayer = $beep

func play(time: float = 0.1, pitch: float = 1.0):
	if not GameSettings.Audio_Enabled:
		return
	if beep.playing:
		beep.stop()
	if time > 1.0:
		time = 1.0
	beep.pitch_scale = pitch
	beep.play(1.0-time)
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
