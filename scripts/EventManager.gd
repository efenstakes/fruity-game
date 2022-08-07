extends Node


# Declare events
signal fruit_hit

signal knife_flight_started
signal knife_flight_ended

signal set_fruits_in_play(num)
signal restart_game

signal set_level(lev)
signal set_sublevel(lev)



func fruit_hit_event():
	emit_signal("fruit_hit")
	
	
func knife_flight_started_event():
	emit_signal("knife_flight_started")
	
func knife_flight_ended_event():
	emit_signal("knife_flight_ended")
	
func restart_game_event():
	emit_signal("restart_game")
	
func set_fruits_in_play_event(num: int):
	emit_signal("set_fruits_in_play", num)


func set_level_event(lev: int):
	emit_signal("set_level", lev)

func set_sublevel_event(lev: int):
	emit_signal("set_sublevel", lev)
