extends Node

var music_volume: int = 3
var sfx_volume: int = 3

var normal_button_color = Color("355570")
var selected_button_color = Color("cccccc")

var level_list := {
	"res://scenes/levels/level1.tscn": true,
	"res://scenes/levels/level2.tscn": false,
	"res://scenes/levels/level3.tscn": false,
	
}

var current_scene: String
var current_level

onready var screen_transiton: CanvasLayer = get_node("/root/SceneManager/ScreenTransition")
onready var scene_container: Node2D = get_node("/root/SceneManager/CurrentScene")
onready var music_stream: AudioStreamPlayer = get_node("/root/SceneManager/MusicAudio")


func _ready() -> void:
	set_stream_volume()


func _input(event):
	if event.is_action_pressed("ctrl"):
		Utils.print_screen()


# Set of functions for scene management and transition between scenes
func set_scene(scene: String, fade: bool = true) -> void:
	current_scene = scene
	
	if fade:
		screen_transiton.transition()
	elif not fade:
		switch_scenes_without_fade()


func switch_scenes() -> void:
	for scene in scene_container.get_children():
		scene.queue_free()
	
	scene_container.add_child(load(current_scene).instance())


func switch_scenes_without_fade() -> void:
	for scene in scene_container.get_children():
		scene.queue_free()
	
	scene_container.add_child(load(current_scene).instance())


func update_level_list():
	var path = current_level.get_filename()
	
	if path in level_list.keys():
		level_list[path] = true
		print(level_list)

# Helper function to play randomized sound effects
func play_audio(audio_player: AudioStreamPlayer, sound_list: Array) -> void:
	var sound = Utils.choose(sound_list)
	audio_player.stream = load(sound)
	

func set_stream_volume() -> void:
	match music_volume:
		5:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 0)
		4:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -4)
		3:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -8)
		2:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -12)
		1:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), -18)
	
	match sfx_volume:
		5:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), 0)
		4:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), -6)
		3:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), -12)
		2:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), -18)
		1:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), -24)

#Todo

#	Global background color
#	Controls mini tutorial
#	Acessibility
#	Add comments
#	Search some helper functions 
#	Randomize sound pitch 
