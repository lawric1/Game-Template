extends Control

var selection_index := 0

export(Array, NodePath) var buttons: Array


func _ready() -> void:
	highlight_selected_button()
	

func _input(event) -> void:
	if event.is_action_pressed("action") or event.is_action_pressed("ui_accept"):
		press_selected_button()
	
	if event.is_action_pressed("up"):
		selection_index -= 1
		highlight_selected_button()
	if event.is_action_pressed("down"):
		selection_index += 1
		highlight_selected_button()
	
	
func highlight_selected_button() -> void:
	selection_index = int(clamp(selection_index, 0, buttons.size() - 1))
	
	reset_button_colors()
	
	var current_button = get_node(buttons[selection_index])
	current_button.add_color_override("font_color", Global.selected_button_color)


func reset_button_colors() -> void:
	for button in buttons:
		get_node(button).add_color_override("font_color", Global.normal_button_color)
	

func press_selected_button() -> void:
	if selection_index == 0:
		Global.set_scene("res://Scenes/Levels/Level1.tscn")
	elif selection_index == 1:
		Global.set_scene("res://Scenes/UI/Menu/Level Selection/LevelSelection.tscn", false)
	elif selection_index == 2:
		Global.set_scene("res://Scenes/UI/Menu/Settings/Settings.tscn", false)


