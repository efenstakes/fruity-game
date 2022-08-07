extends Node2D


onready var Fruit = preload("res://scenes/Fruit.tscn")
onready var SpeedTimer = $SpeedTimer


var width: int


const SLOW_SPEED: float = 0.7
const REGULAR_SPEED: float = 1.0
const MID_SPEED: float = 2.0
const HIGH_SPEED: float = 3.0

var SPEED: float = REGULAR_SPEED


enum FRUIT_POSITION { OUTER, MID, INNER }





# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.connect("restart_game", self, "_onRestartGame")
	width = get_viewport().size.x
	SpeedTimer.start( rand_range(5, 16) )
	position_rotator()
	start()
	
	
	
	
func position_rotator():	
	position.x = width/2
	position.y = get_viewport().size.y / 2.8
	
	
func start():
	SPEED = REGULAR_SPEED
	
	var start_number: int = rand_range(7, 10)
	var total_fruits = start_number + (start_number - 2) + (start_number/2)

	print("fruits to show ", total_fruits)
		
	set_inner(start_number/2)
	set_mid(start_number-2)
	set_outer(start_number)
		
	EventManager.set_fruits_in_play_event( total_fruits )





func set_inner(fruits_to_show):
	var offset_degrees = 360 / fruits_to_show
	
#	print("fruits to show ", fruits_to_show)

	for index in range(fruits_to_show):
		build_fruit(
			Fruit.instance(),
			FRUIT_POSITION.INNER,
			index,
			offset_degrees
		)
		
			
func set_mid(fruits_to_show):
#	var fruits_to_show: int = rand_range(5, 8)
	var offset_degrees = 360 / fruits_to_show
	
#	print("fruits to show ", fruits_to_show)
	
	for index in range(fruits_to_show):
		build_fruit(
			Fruit.instance(),
			FRUIT_POSITION.MID,
			index,
			offset_degrees
		)
	
func set_outer(fruits_to_show):
	var center_offset = (width/2) * .45
	
#	var fruits_to_show: int = rand_range(7, 10)
	var offset_degrees = 360 / fruits_to_show
	
#	print("fruits to show ", fruits_to_show)
	
	for index in range(fruits_to_show):
		build_fruit(
			Fruit.instance(),
			FRUIT_POSITION.OUTER,
			index,
			offset_degrees
		)


func _physics_process(delta):
	rotate( deg2rad(SPEED) )
	
	
	

func get_center_offset(posi):
	var offset_variant = .45
	
	match posi:
		FRUIT_POSITION.INNER:
			offset_variant = .25
		FRUIT_POSITION.MID:
			offset_variant = .5
		FRUIT_POSITION.OUTER:
			offset_variant = .8
		
	return (width/2) * offset_variant
	
	
func build_fruit(fruit_instance, posi, index, offset_degrees):
	var center_offset = get_center_offset(posi)
			
	var new_node_instance = Node2D.new()
	fruit_instance.position.x += center_offset
	new_node_instance.add_child(fruit_instance)
	new_node_instance.rotate( deg2rad(index * offset_degrees) )
	add_child(new_node_instance)
	

func reset_speed():
	var speeds = [ SLOW_SPEED, REGULAR_SPEED, MID_SPEED, HIGH_SPEED ]
	SPEED = speeds[rand_range(0, 3)]


func clear_existing_fruits():
	for frt in get_tree().get_nodes_in_group("FRUITS"):
		frt.queue_free()


func _onRestartGame():
	clear_existing_fruits()

	yield( get_tree().create_timer(.5), "timeout" )
	
	start()


func _on_SpeedTimer_timeout():
	reset_speed()
	SpeedTimer.start( rand_range(11, 22) )

	
