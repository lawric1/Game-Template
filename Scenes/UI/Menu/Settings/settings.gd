extends "res://scenes/ui/menu/ui_button_selection.gd"

var sprite_size := 10

var on_volume_slider: bool = true
var slider: Array = [Global.music_volume, Global.sfx_volume]
var icon: Array = []

onready var music_volume_icon: TextureRect = $MusicVolume2
onready var sfx_volume_icon: TextureRect = $MusicVolume4

func _ready() -> void:
	music_volume_icon.rect_size.x = Global.music_volume * sprite_size
	sfx_volume_icon.rect_size.x = Global.sfx_volume * sprite_size
	
	icon = [music_volume_icon, sfx_volume_icon]


func _input(event) -> void:
	if selection_index == 0 or selection_index == 1:
		on_volume_slider = true
	else:
		on_volume_slider = false
		
	if on_volume_slider:
		if event.is_action_pressed("left"):
			slider[selection_index] -= 1
		if event.is_action_pressed("right"):
			slider[selection_index] += 1
		
		slider[selection_index] = int(clamp(slider[selection_index], 1, 5))
		icon[selection_index].rect_size.x = slider[selection_index] * sprite_size

	Global.music_volume = slider[0]
	Global.sfx_volume = slider[1]
	Global.set_stream_volume()
	
	
func press_selected_button() -> void:
	if selection_index == 2:
		Global.set_scene("res://scenes/ui/menu/menu.tscn", false)
