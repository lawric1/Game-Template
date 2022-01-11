extends Camera2D

var magnitude := 0
var default_offset := offset

onready var shake_timer: Timer = $Timer
onready var tween: Tween = $Tween  


func _ready() -> void:
	Utils.camera_shake = self
	offset = get_viewport_rect().size / 2
	current = true
	
	set_process(false)


func _process(delta) -> void:
	offset = Vector2(rand_range(-magnitude, magnitude), 
			rand_range(-magnitude, magnitude)) * delta + default_offset
	
	
func shake(new_magnitude: int, shake_time: float = 0.1) -> void:
	magnitude += new_magnitude
	shake_timer.wait_time = shake_time
	
	var _v = tween.stop_all()
	set_process(true)
	shake_timer.start()


func _on_Timer_timeout() -> void:
	magnitude = 0
	set_process(false)
	
	var _v = tween.interpolate_property(self, "offset", offset, default_offset, 
			0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
	_v = tween.start()

