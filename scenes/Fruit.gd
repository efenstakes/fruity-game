extends Area2D


onready var SliceTween = $SliceTween



# Called when the node enters the scene tree for the first time.
func _ready():
	register_animation()


func _on_Fruit_area_entered(area):
	if area.is_in_group("KNIVES"):
		EventManager.fruit_hit_event()
		
		# disable collision shapes
		$CollisionShape2D.disabled = true
		
		SliceTween.start()



func register_animation():
	SliceTween.interpolate_property(
			$Sprite,
			"scale",
			$Sprite.get_scale(),
			Vector2(0, 0),
			.5,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT
	)
	
	


func _on_SliceTween_tween_all_completed():
	print("tween done, queue_free")
	queue_free()
