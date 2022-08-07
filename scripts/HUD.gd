extends CanvasLayer



onready var LevelLabel = $MarginContainer/Display/LevelDisplay/Level
onready var SubLevelLabel = $MarginContainer/Display/SubLevelDisplay/SubLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	LevelLabel.text = str(1)
	SubLevelLabel.text = str(1)
	
	EventManager.connect("set_sublevel", self, "_onSubLevelSet")
	EventManager.connect("set_level", self, "_onLevelSet")




func _onSubLevelSet(lev):
	SubLevelLabel.text = str(lev)
	
func _onLevelSet(lev):
	LevelLabel.text = str(lev)
	
