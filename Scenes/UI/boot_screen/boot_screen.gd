extends Node2D

func _on_AnimationPlayer_animation_finished(_anim_name) -> void:
	Global.set_scene("res://scenes/ui/menu/menu.tscn")
