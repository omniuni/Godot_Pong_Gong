extends SaveableNode

var Audio_Enabled: bool = true:
	set(value):
		Audio_Enabled = value
		_save()
		pass

var Rounds: int = 3:
	set(value):
		Rounds = value
		_save()
		pass

var Color_P1: Color = Color(0,0,0):
	set(value):
		Color_P1 = value
		_save()
		pass
var Color_P2: Color = Color(.5,.5,.5):
	set(value):
		Color_P2 = value
		_save()
		pass
