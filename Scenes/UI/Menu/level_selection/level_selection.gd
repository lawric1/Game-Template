extends Control

export(Texture) var normal_icon_texture: Texture
export(Texture) var selected_icon_texture: Texture

var grid_icons: Array
var active_icons: Array

var current_selection_position := Vector2.ZERO
var previous_selection_position := Vector2.ZERO
var current_selection

var row: int
var col: int

var icon_scene := load("res://scenes/ui/menu/level_selection/level_icon.tscn")


func _ready() -> void:
	generate_icons()
	set_current_selection()


func _input(event) -> void:
	var values: Array = find_row_col()
	row = values[0]
	col = values[1]
	
	if event.is_action_pressed("action") or event.is_action_pressed("ui_accept"):
		press_selected_button()
	
	if not current_selection is Label:
		if event.is_action_pressed("up"):
			current_selection_position.y -= 1
			handle_bounds("up")
			
		if event.is_action_pressed("down"):
			current_selection_position.y += 1
			handle_bounds("down")
			
		if event.is_action_pressed("left"):
			current_selection_position.x -= 1
			handle_bounds("left")
			
		if event.is_action_pressed("right"):
			current_selection_position.x += 1
			handle_bounds("right")
			
	else:
		if event.is_action_pressed("up"):
			current_selection_position = previous_selection_position
			current_selection_position.y = col - 1
			
		if event.is_action_pressed("down"):
			current_selection_position = previous_selection_position
			current_selection_position.y = 0
	
	set_current_selection()
	

func press_selected_button() -> void:
	if current_selection is TextureRect:
		Global.set_scene(current_selection.level_path)
		
		
	if current_selection is Label:
		Global.set_scene("res://scenes/ui/menu/menu.tscn", false)
		
		
func set_current_selection() -> void:
	for icon in active_icons:
		if icon.grid_position == current_selection_position:
			current_selection = icon

	reset_selection_texture()
	
	if current_selection is TextureRect:
		current_selection.texture = selected_icon_texture
		
	if current_selection is Label:
		current_selection.add_color_override("font_color", Global.selected_button_color)
	

func reset_selection_texture() -> void:
	for icon in active_icons:
		icon.texture = normal_icon_texture
		
	$Back.add_color_override("font_color", Global.normal_button_color)
	

func handle_back_button() -> void:
	previous_selection_position = current_selection_position
	current_selection = $Back
	
	reset_selection_texture()
	
	current_selection.add_color_override("font_color", Global.selected_button_color)
	

func handle_bounds(direction: String) -> void:
	if direction == "up":
		if current_selection_position.y < 0:
			handle_back_button()
			
	if direction == "down":
		if current_selection_position.y > col - 1:
			handle_back_button()
			
	if direction == "left":
		if current_selection_position.x < 0:
			current_selection_position.x = row - 1
		
	if direction == "right":
		current_selection_position.x = int(current_selection_position.x) % (row)
		
		
func find_row_col() -> Array:
	var row_count: int = 0
	var col_count: int = 0
	
	var positions: Array = []
	
	for icon in active_icons:
		positions.append(icon.grid_position)
	
	for pos in positions:
		if pos.y == current_selection_position.y:
			row_count += 1
		
		if pos.x == current_selection_position.x:
			col_count += 1
			
	return [row_count, col_count]


func generate_icons() -> void:
	var positions := []
	
	for y in 5:
		for x in 5:
			positions.append(Vector2(float(x), float(y)))
	
	for i in Global.level_list.size():
		var icon = icon_scene.instance()
		icon.grid_position = positions[i]
		icon.level_path = Global.level_list.keys()[i]
		icon.is_active = Global.level_list[icon.level_path]
		
		$GridContainer.add_child(icon)
	
	grid_icons = $GridContainer.get_children()
	
	for icon in grid_icons:
		if icon.is_active:
			active_icons.append(icon)
			
	
	
	
