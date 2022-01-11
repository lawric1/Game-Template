extends Node2D


func _ready():
	Global.current_level = self
	Global.update_level_list()
	

func _input(event):
	if event.is_action_pressed("ctrl"):
		Global.set_scene("res://scenes/levels/level2.tscn")

