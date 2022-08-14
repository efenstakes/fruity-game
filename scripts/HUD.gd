extends CanvasLayer



onready var LevelLabel = $MarginContainer/Display/LevelDisplay/Level
onready var SubLevelLabel = $MarginContainer/Display/SubLevelDisplay/SubLevel
onready var HitsLabel = $MarginContainer/Display/HitsDisplay/Hits

onready var LevelTween = $LevelTween
onready var SubLevelTween = $SubLevelTween
onready var HitsTween = $HitsTween


var level: int = 1
var sub_level: int = 1
var hits_total: int = 0


const ANIMATION_DURATION: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	level = 1
	sub_level = 1
	LevelLabel.text = str(level)
	SubLevelLabel.text = str(sub_level)
	
	EventManager.connect("set_sublevel", self, "_onSubLevelSet")
	EventManager.connect("set_level", self, "_onLevelSet")
	EventManager.connect("fruit_hit", self, "_onFruitHit")
	
	
#	run_animation()



func run_animation():
	print("run_animation starting")
	LevelTween.interpolate_method(
		self,
		"_AddElevelLabelText",
		10,
		3500,
		100,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	LevelTween.interpolate_property(
		LevelLabel,
		"rect_scale",
		Vector2(1, 1),
		Vector2(3, 3),
		1,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	LevelTween.start()



func _AddElevelLabelText(val):
	LevelLabel.text = str(int(val))	


func _onSubLevelSet(lev):
	SubLevelTween.stop_all()
	SubLevelTween.interpolate_method(
		self,
		"_onSubLevelSetCallback",
		level,
		lev,
		ANIMATION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	SubLevelTween.interpolate_property(
		SubLevelLabel,
		"rect_scale",
		Vector2(1, 1),
		Vector2(3, 3),
		ANIMATION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	SubLevelTween.start()
#	SubLevelLabel.text = str(lev)
	

func _onSubLevelSetCallback(val):
	sub_level += val
	SubLevelLabel.text = str(int(val))
	
	
	

func _onLevelSet(lev):
	LevelTween.stop_all()
	LevelTween.interpolate_method(
		self,
		"_onLevelSetCallback",
		sub_level,
		lev,
		ANIMATION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	LevelTween.interpolate_property(
		LevelLabel,
		"rect_scale",
		Vector2(1, 1),
		Vector2(3, 3),
		ANIMATION_DURATION,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	LevelTween.start()
	
	
func _onLevelSetCallback(val):
	level += val
	LevelLabel.text = str(int(val))


func _onFruitHit():
	hits_total += 1
	HitsLabel.text = str(int(hits_total))
#	HitsTween.stop_all()
	HitsTween.interpolate_method(
		self,
		"_onFruitHitCallback",
		hits_total,
		hits_total + 1,
		ANIMATION_DURATION / 10,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	HitsTween.interpolate_property(
		HitsLabel,
		"rect_scale",
		Vector2(1, 1),
		Vector2(3, 3),
		ANIMATION_DURATION / 10,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
#	HitsTween.start()
	yield(HitsTween, "tween_completed")
	HitsTween.interpolate_property(
		HitsLabel,
		"rect_scale",
		Vector2(3, 3),
		Vector2(1, 1),
		ANIMATION_DURATION / 10,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
#	HitsTween.start()
#	hits_total += 1
#	HitsLabel.text = str(hits_total)

	
func _onFruitHitCallback(val):
	HitsLabel.text = str(int(hits_total))
	

func _on_LevelTween_tween_all_completed():
	print("Level Tween Done")
	if LevelLabel.rect_scale == Vector2(3, 3):
		print("Level Tween Done if")	
		LevelTween.interpolate_property(
			LevelLabel,
			"rect_scale",
			Vector2(3, 3),
			Vector2(1, 1),
			ANIMATION_DURATION,
			Tween.TRANS_LINEAR,
			Tween.TRANS_LINEAR
		)
		LevelTween.start()


func _on_SubLevelTween_tween_all_completed():
	print("SubLevel Tween Done")
	if SubLevelLabel.rect_scale == Vector2(3, 3):
		print("SubLevel Tween Done if")	
		SubLevelTween.interpolate_property(
			SubLevelLabel,
			"rect_scale",
			Vector2(3, 3),
			Vector2(1, 1),
			ANIMATION_DURATION,
			Tween.TRANS_LINEAR,
			Tween.TRANS_LINEAR
		)
		SubLevelTween.start()
