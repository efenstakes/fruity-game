extends Area2D


onready var SliceTween = $SliceTween



const textures = [
	"res://assets/Fruits/fruit1.png",
	"res://assets/Fruits/fruit2.png",
	"res://assets/Fruits/fruit3.png",
	"res://assets/Fruits/fruit4.png",
	"res://assets/Fruits/fruit5.png",
	"res://assets/Fruits/fruit6.png",
	"res://assets/Fruits/fruit7.png",
	"res://assets/Fruits/fruit8.png",
	"res://assets/Fruits/fruit9.png",
	"res://assets/Fruits/fruit10.png",
	"res://assets/Fruits/fruit11.png",
	"res://assets/Fruits/fruit12.png",
	"res://assets/Fruits/fruit13.png",
	"res://assets/Fruits/fruit14.png",
	"res://assets/Fruits/fruit15.png",
	"res://assets/Fruits/fruit16.png",
	"res://assets/Fruits/fruit17.png"
]





# Called when the node enters the scene tree for the first time.
func _ready():	
	$Sprite.set_texture(
		load(
			textures[ rand_range(0, (textures.size() - 1 )) ]
		)
	)
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
