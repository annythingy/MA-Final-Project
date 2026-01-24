extends CharacterBody2D

var acceleration_rate = Vector2(128, 512) 
var brake_rate = 64.0  # speed units per second squared (scalar)
var car_width = 32
var water_supply = 1
	
func _physics_process(delta):
	global_position.x = clamp(global_position.x, 560, 1000)
	global_position.y = clamp(global_position.y,  car_width, 480)
	move_x(delta)
	move_y(delta)
	$"../../UI/WaterTank".value = water_supply
	
	var collision_data = move_and_collide(velocity * delta)
	if collision_data:
		if collision_data.get_collider().age  && collision_data.get_collider().age < 3:
			collision_data.get_collider().wither()
		else: velocity = Vector2.ZERO

func move_x(delta):
	if Input.is_action_just_pressed("fUp"): position.y -= acceleration_rate.y * delta
	elif Input.is_action_just_pressed("fDown"): position.y += acceleration_rate.y * delta
	else: idle()
	
func move_y(delta):
	if 	 Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):	velocity.x -= acceleration_rate.x * delta
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):	velocity.x += acceleration_rate.x * delta
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):	splash_on()
	else: idle()

func idle(): velocity = velocity.lerp(Vector2.ZERO, 0.02)

func brake(delta):
	var speed = velocity.length()
	speed -= brake_rate * delta
	speed = max(speed, 0)
	velocity = velocity.normalized() * speed if speed > 0 else Vector2.ZERO

func splash_on():
	if !water_supply:
		print("dry heave")
		return
	$SplashArea.visible = true
	$SplashArea/SplashCollider.disabled = false
	var fire = $SplashArea.get_overlapping_areas()
	for f in fire: f.get_parent().put_off_fire()
	splash_off()

func splash_off():
	water_supply -= 1
	await get_tree().create_timer(0.8).timeout
	$SplashArea/SplashCollider.disabled = true
	$SplashArea.visible = false
	
