extends CharacterBody2D

var acceleration_rate = Vector2(-128, -256) 
var brake_rate = 64.0  # speed units per second squared (scalar)
var car_width = 32
	
func _physics_process(delta):
	global_position.x = clamp(global_position.x, 560, 1000)
	global_position.y = clamp(global_position.y,  car_width, 480)
	
	if Input.is_action_just_pressed("fUp"): goUp(delta)
	elif Input.is_action_just_pressed("fDown"): goDown(delta)
	else: idle()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		goForwards(delta)
	elif Input.is_mouse_button_pressed(2 as MouseButton):
		goBackwards(delta)
	elif Input.is_mouse_button_pressed(3 as MouseButton):
		if velocity>Vector2.ZERO: brake(delta)
		else: splash()
	else: idle()
	
	if Input.is_action_just_pressed("spray"): splash()
	
	var collision_data = move_and_collide(velocity * delta)
	if collision_data:
		if collision_data.get_collider().age  && collision_data.get_collider().age < 3:
			collision_data.get_collider().wither()
		else: velocity = Vector2.ZERO
			
func goForwards(delta):
	velocity.x += acceleration_rate.x * delta

func goBackwards(delta):
	velocity.x -= acceleration_rate.x * delta

func goUp(delta):
	velocity.y += acceleration_rate.y * delta
	
func goDown(delta):
	velocity.y -= acceleration_rate.y * delta
	
func idle():
	velocity = velocity.lerp(Vector2.ZERO, 0.02)

func brake(delta):
	var speed = velocity.length()
	speed -= brake_rate * delta
	speed = max(speed, 0)
	velocity = velocity.normalized() * speed if speed > 0 else Vector2.ZERO

func splash():
	$Area2D/CollisionShape2D2.disabled = false
	var fire = $Area2D.get_overlapping_areas()
	for f in fire:
		f.get_parent().set_off_fire()
	await get_tree().create_timer(1.0).timeout
	$Area2D/CollisionShape2D2.disabled = true
	
