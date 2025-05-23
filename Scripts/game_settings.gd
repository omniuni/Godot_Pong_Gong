extends SaveableNode

## Autoload Singleton, represents game settings.
## Autoloads MUST extend Node.

var Audio_Enabled: bool = true:
	set(value):
		Audio_Enabled = value
		_save()
		pass

var Rounds: int = 3

var Color_P1: Color = Color(0,0,0)
var Color_P2: Color = Color(.5,.5,.5)
