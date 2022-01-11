extends CanvasLayer

func transition() -> void:
	$AnimationPlayer.stop()
	$AnimationPlayer.play("fade_in")


func _on_AnimationPlayer_animation_finished(anim_name) -> void:
	if anim_name == "fade_in":
		Global.switch_scenes()
		
		$AnimationPlayer.play("fade_out")
