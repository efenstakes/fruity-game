extends Node




#no restarts happened in level 2 sublevel 2


var fruits_hit_in_flight: int = 0
var total_fruits_hit_in_sl: int = 0
var fruits_in_play: int = 0

var current_level: int = 1
var current_sublevel: int = 1
const TOTAL_SUBLEVELS: int = 2



# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.connect("fruit_hit", self, "_onFruitHit")
	EventManager.connect("knife_flight_started", self, "_onKnifeFlightStarted")
	EventManager.connect("knife_flight_ended", self, "_onKnifeFlightEnded")
	EventManager.connect("set_fruits_in_play", self, "_onSetFruitsInPlay")



func _onSetFruitsInPlay(num: int)-> void:
	fruits_in_play = num
	

func _onFruitHit():
	fruits_hit_in_flight += 1
	total_fruits_hit_in_sl += 1
	
#	print("fruits_hit_in_flight ", fruits_hit_in_flight)
#	print("total_fruits_hit_in_sl ", total_fruits_hit_in_sl)
#	print("fruits_in_play ", fruits_in_play)

	if total_fruits_hit_in_sl == fruits_in_play:
		total_fruits_hit_in_sl = 0
		
		if current_sublevel == TOTAL_SUBLEVELS:
			current_sublevel = 1
			current_level += 1
			print("NEW current_level ", current_level)
			EventManager.set_level_event(current_level)
			
		else:
			current_sublevel += 1
			
		print("DONE MATE")		
		print("NEW current_sublevel ", current_sublevel)
		EventManager.set_sublevel_event(current_sublevel)
		
		
		# wait for a while to give the last fruits 
		# that just got hit time to animate
		yield( get_tree().create_timer(1), "timeout" )
		
		# restart game
		EventManager.restart_game_event()
		
#	if total_fruits_hit_in_sl == fruits_in_play or current_sublevel == TOTAL_SUBLEVELS:
#		print("DONE MATE")
#		EventManager.restart_game_event()


func _onKnifeFlightStarted():
	fruits_hit_in_flight = 0



#if fruits_hit is zero, reload game
func _onKnifeFlightEnded():
	print("current_sublevel ", current_sublevel)
	print("current_level ", current_level)
	
	print("flight over hits ", fruits_hit_in_flight)
	if fruits_hit_in_flight == 0:
		total_fruits_hit_in_sl = 0
#		get_tree().paused = true
		yield(
			get_tree().create_timer(1, false),
			"timeout"
		)
#		get_tree().paused = false
#		get_tree().reload_current_scene()
		print("YOU DIDNT HIT A THING")
		EventManager.restart_game_event()
