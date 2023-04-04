extends Node2D

var pipe_speed = 200
var pipe_gap_size = 200

func _ready():
	var pipe_offset = randf_range(-200, 200)
	position.y = pipe_offset;

func _process(delta):
	if get_tree().root.get_node("Game").is_game_over == false and get_tree().root.get_node("Game").is_game_started:
		position.x -= pipe_speed * delta
	if position.x < -1500:
		queue_free()

#func _on_TopPipe_body_entered(body):
#	if body.name == "Bird":
#		get_tree().call_group("pipes", "queue_free")
#		emit_signal("body_entered", body)
#
#func _on_BottomPipe_body_entered(body):
#	if body.name == "Bird":
#		get_tree().call_group("pipes", "queue_free")
#		emit_signal("body_entered", body)

func _on_ScoreArea_body_entered(body):
	if str(body.name).contains("Player"):
		body.inc_score()
