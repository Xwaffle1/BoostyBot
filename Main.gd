extends Node2D

var gravity = 800
var jump_power = 400
var pipe_speed = 200
var pipe_offset = 300
var score = 0
var pipe_scene = load("res://Pipe.tscn")
var player_scene = load("res://Player.tscn")
var point_boost_scene = load("res://PointBoost.tscn")
var player
var is_game_over = false
var is_game_started = false

func _ready():
	player = player_scene.instantiate()
	player.position = Vector2(-300, 0)
	$Foreground.add_child(player)
	await get_tree().create_timer(1).timeout
	$Countdown.play()
	$GameStartTimer.start(3)
	randomize()
	
func _process(delta):
	if $GameStartTimer.time_left != 0:
		var textVal = str(ceil($GameStartTimer.time_left))
		if $GameStartTimer.time_left <= 0:
			textVal = 'GO!'
		$Foreground/Countdown.text = textVal
	elif is_game_started:
		$Foreground/Countdown.text = 'Go!'
		await get_tree().create_timer(1).timeout
		$Foreground/Countdown.visible = false
		$Foreground/Score.visible = true

func _on_Pipe_body_entered(body):
	if body.name == "Bird":
		get_tree().reload_current_scene()

func inc_score(amt = 1):
	score += amt
	$Foreground/Score.text = str(score)
	$Score.play(0)

func _on_PipeSpawnTimer_timeout():
	print('Spawn Pipe')
	var pipe_instance = pipe_scene.instantiate()
	pipe_instance.position = Vector2(0, 0)
	$Foreground/Pipes.add_child(pipe_instance)
	
	if randi_range(1, 2) == 1:
		var offset = pipe_instance.pipe_offset
		var point_boost = point_boost_scene.instantiate()
		var point_boost_y = abs(offset) + randi_range(70, 100);
		if offset > 0:
			point_boost_y *= -1;
		point_boost.position = Vector2(-200 - randf_range(0, 100), point_boost_y)
		pipe_instance.add_child(point_boost)
	
func game_over():
	$GameOver.play()
	is_game_over = true;
	await get_tree().create_timer(1).timeout
	$InGameMenu.visible = true
	$Foreground/PipeSpawnTimer.stop()


func _on_game_start_timer_timeout():
	is_game_started = true
	$Foreground/PipeSpawnTimer.start(3);


func _on_restart_button_pressed():
	get_tree().reload_current_scene()
