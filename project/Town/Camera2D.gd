extends Camera2D



func _process(_delta):
	var player = get_node_or_null("/root/Tumbleweed/Player")
	if player != null:
		position = player.position
