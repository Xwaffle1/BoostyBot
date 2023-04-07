extends ParallaxBackground


func _process(delta):
	if get_tree().root.has_node("Game") != null:
		if !get_tree().root.get_node("Game").is_game_over and get_tree().root.get_node("Game").is_game_started:
			$ParallaxLayer.motion_offset.x += -60 * delta
	else:
		$ParallaxLayer.motion_offset.x += -60 * delta
