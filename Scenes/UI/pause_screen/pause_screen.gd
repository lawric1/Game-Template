extends "res://scenes/ui/menu/ui_button_selection.gd"

var pause_state := false


func _input(event) -> void:
	if event.is_action_pressed("escape"):
		pause_game()
		

func press_selected_button() -> void:
	if selection_index == 0 and pause_state:
		pause_game()
		
#	elif selection_index == 1:
#		Global.set_scene("res://Scenes/Menu/Settings.tscn", false)
		
	elif selection_index == 1 and pause_state:
		Global.set_scene("res://scenes/ui/menu/menu.tscn")
		pause_game()


func pause_game():
	pause_state = not get_tree().paused
	get_tree().paused = pause_state
	visible = pause_state
