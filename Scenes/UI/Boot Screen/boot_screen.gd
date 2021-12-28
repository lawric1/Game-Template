extends Node2D

func _on_AnimationPlayer_animation_finished(_anim_name) -> void:
	Global.set_scene("res://Scenes/UI/Menu/Menu.tscn")
