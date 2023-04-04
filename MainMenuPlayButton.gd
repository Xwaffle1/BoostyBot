extends TextureButton


func _on_pressed():
	self.get_tree().change_scene_to_file("res://Main.tscn")
