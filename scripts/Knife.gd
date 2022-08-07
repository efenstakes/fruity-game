extends Area2D


onready var SpriteButton = $TouchScreenButton
onready var BounceTween = $BounceTween


var is_paused = false
var is_in_flight: bool = false



var SPEED: float = 2000
var initial_position: Vector2 = Vector2.ZERO
var initial_button_position: Vector2 = Vector2.ZERO





# Called when the node enters the scene tree for the first time.
func _ready():
	position_knife()
	initial_position = position
	initial_button_position = SpriteButton.position
	register_animations()



func position_knife():	
	var screen_size: Vector2 = get_viewport().size
	position.x = screen_size.x/2
	position.y = screen_size.y - ( screen_size.y / 7 )
	
	
	
	
	
func _physics_process(delta):
	if !is_in_flight and !BounceTween.is_active():
		BounceTween.start()
		
	if is_paused:
		return
		
	if !is_in_flight and Input.is_action_just_pressed("ui_up"):
		initiate_flight()

	if !is_in_flight and !Input.is_action_just_pressed("ui_up"):
		return
	
	
	position.y -= SPEED * delta



func _on_TouchScreenButton_pressed():
	print("pressed knife")
	if is_in_flight:
		return
		
	initiate_flight()



func initiate_flight():
	BounceTween.stop_all()
	is_in_flight = true
	# signal that we are in flight
	EventManager.knife_flight_started_event()


func _on_VisibilityNotifier2D_screen_exited():
	print("OOOPS, OUTSIDE SCREEN")
	is_in_flight = false
	
	is_paused = true
	yield( get_tree().create_timer(.3, false), "timeout" )
	is_paused = false
	
	position = initial_position
	# signal that flight just ended
	EventManager.knife_flight_ended_event()



func register_animations():
	BounceTween.interpolate_property(
		self,
		"position",
		Vector2(
			position.x, 
			position.y + 20 
		),
		initial_position,
		2.5,
		Tween.EASE_IN_OUT, # TRANS_QUINT, # Tween.EASE_IN,
		Tween.EASE_OUT_IN # Tween.TRANS_QUART
	)
	BounceTween.set_repeat(true)
