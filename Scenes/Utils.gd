extends Node

var shake_camera


func show_collision_shapes() -> void:
	var start_node: Node = get_node("/root/")
	var collision_list := []
	var target_nodes := ["CollisionShape2D", "RayCast2D", "TileMap"]
	
	find_nodes(start_node, collision_list, target_nodes)
	
	for collision in collision_list:
		if collision is CollisionShape2D:
			collision.visible = not collision.visible
		
		if collision is RayCast2D:
			collision.visible = not collision.visible
			
		if collision is TileMap:
			collision.show_collision = not collision.show_collision


func find_nodes(node, node_list: Array, target_nodes):
	if node.get_children():
		for child in node.get_children():
			if child.get_class() in target_nodes:
				node_list.append(child)
				
			var _result = find_nodes(child, node_list, target_nodes)


func choose(list: Array):
	randomize()
	var index = randi() % list.size()
	
	return list[index]
	pass


func print_screen() -> void:
	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.save_png("res://mockup.png")
