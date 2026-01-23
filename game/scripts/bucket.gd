extends Area2D

@export var tank_capacity = 8
var water_collected = 0
var direction = 64
var up_incr = 0.16
var idle_on = false

func b_width(): return  32 * $CollisionShape2D.scale.x
func x_left(): 	return  64 + b_width() / 2
func x_right(): return 480 - b_width() / 2

func _ready() -> void:
	$WaterTank/TextureBar.max_value = tank_capacity

func _physics_process(delta):
	if idle_on:
		global_position.x += delta * direction
		if global_position.x < x_left() || global_position.x > x_right():
			direction = -direction
	else:
		global_position.x = clamp(global_position.x, x_left(), x_right())
	
	if Input.is_action_pressed("wLeft"): position -= Vector2(100, 0) * delta
	if Input.is_action_pressed("wRight"): position += Vector2(100, 0) * delta
	
func _on_area_entered(drop: Area2D) -> void:
	water_collected += 1
	drop.queue_free()
	if water_collected >= tank_capacity:
		water_collected = 0
	$WaterTank/TextureBar.value = water_collected
	$WaterTank/Amount.text  = str(water_collected)

func upgrade():
	$Sprite2D.scale.x +=up_incr
	$CollisionShape2D.scale.x += up_incr
	$WaterTank.position.x -= up_incr * 16
	$"../../World/Rain".spawn_cloud()

func _on_check_button_toggled(toggled_on: bool) -> void:
	idle_on = toggled_on

func _on_button_pressed() -> void:
	upgrade()
