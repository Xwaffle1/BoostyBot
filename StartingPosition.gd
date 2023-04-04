extends Area2D


func _input(event):
	if event.is_action_pressed("ui_accept"):
		velocity.y = -400

func _on_Area2D_body_entered(body):
	if body.name == "Pipe":
		# Game over
