extends CanvasLayer



onready var LevelLabel = $MarginContainer/Display/LevelDisplay/Level
onready var SubLevelLabel = $MarginContainer/Display/SubLevelDisplay/SubLevel

onready var LevelTween = $LevelTween
onready var SubLevelTween = $SubLevelTween


var level = 1
var sub_level = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	level = 1
	sub_level = 1
	LevelLabel.text = str(level)
	SubLevelLabel.text = str(sub_level)
	
	EventManager.connect("set_sublevel", self, "_onSubLevelSet")
	EventManager.connect("set_level", self, "_onLevelSet")




func _onSubLevelSet(lev):
	SubLevelTween.interpolate_method(
		self,
		"_onSubLevelSetCallback",
		sub_level,
		lev,
		2,
		Tween.TRANS_BACK,
		Tween.EASE_IN
	)
#	SubLevelLabel.text = str(lev)
	

func _onSubLevelSetCallback(val):
	SubLevelLabel.text = str(val)
	
	
	
	
func _onLevelSet(lev):
	LevelLabel.text = str(lev)
	
