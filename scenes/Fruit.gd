extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Fruit_area_entered(area):
	if area.is_in_group("KNIVES"):
		EventManager.fruit_hit_event()
		
		# disable collision shapes
		$CollisionShape2D.disabled = true
		
