extends CharacterBody2D

var acceleration_rate = Vector2(-32, 0) 
var brake_rate = 32.0  # speed units per second squared (scalar)

func _physics_process(delta):
	var mouse_y = get_global_mouse_position().y
	global_position.x = clamp(global_position.x, 560, 1000)
	global_position.y = clamp(mouse_y, 32, 480)

	if Input.is_mouse_button_pressed(1 as MouseButton):
		goForwards(delta)
	elif Input.is_mouse_button_pressed(2 as MouseButton):
		goBackwards(delta)
	elif Input.is_mouse_button_pressed(3 as MouseButton):
		brake(delta)
	else: idle()
	var collision_data = move_and_collide(velocity * delta)
	if collision_data:
		if collision_data.get_collider().age  && collision_data.get_collider().age < 3:
			collision_data.get_collider().wither()
		else: velocity = Vector2.ZERO

func goForwards(delta):
	velocity += acceleration_rate * delta

func goBackwards(delta):
	velocity -= acceleration_rate * delta

func idle():
	velocity = velocity.lerp(Vector2.ZERO, 0.02)

func brake(delta):
	var speed = velocity.length()
	speed -= brake_rate * delta
	speed = max(speed, 0)
	velocity = velocity.normalized() * speed if speed > 0 else Vector2.ZERO
