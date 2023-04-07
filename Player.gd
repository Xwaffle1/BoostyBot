extends RigidBody2D

# Declare variables
var jump_power = 600
var gravity = 1000
var max_speed = 0

#func _ready():
#	$Sprite.play("default")

func inc_score(amt = 1):
	get_tree().root.get_node("Game").inc_score(amt)

func _physics_process(delta):
	if !get_tree().root.get_node("Game").is_game_started:
		sleeping = true
		return
	if get_tree().root.get_node("Game").is_game_over:
		set_linear_velocity(Vector2.ZERO)
		set_angular_velocity(0.0)
		sleeping = true
		gravity_scale = 0
		return
		
	if abs(self.position.y) > 300:
		get_tree().root.get_node("Game").game_over()
	# Apply gravity to the player
	apply_force(Vector2(0, gravity))

	# Limit the player's horizontal speed
#	var current_speed = get_linear_velocity().x
#	if abs(current_speed) > max_speed:
#		var new_speed = sign(current_speed) * max_speed
#		set_linear_velocity(Vector2(new_speed, get_linear_velocity().y))
		
	var velocity = get_linear_velocity()
	if velocity.y < 0:
		var angle = lerp(0, -30, abs(velocity.y) / 300)
		$Sprite.rotation_degrees = angle
	elif velocity.y > 0:
		var angle = lerp(0, 20, abs(velocity.y) / 900)
		$Sprite.rotation_degrees = angle
	else:
		$Sprite.rotation_degrees = -30

	
	# Jump when space is pressed
	if Input.is_action_just_pressed("jump"):
		$Jump.play(0)
		$Sprite.play("default")
		set_linear_velocity(Vector2(get_linear_velocity().x, -jump_power))



func _on_detect_body_entered(body):
	if body.name == 'PipeStaticBody':
		get_tree().root.get_node("Game").game_over()
	if body.name == 'PointBoostStaticBody':
		body.get_parent().queue_free();
		inc_score(2)
		
