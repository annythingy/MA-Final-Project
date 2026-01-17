extends Area2D

@export var tank_capacity = 8
var water_collected = 0
var direction = 8
var idle_on = false

func _ready() -> void:
	$WaterTank/TextureBar.max_value = tank_capacity

func _physics_process(delta):
	if idle_on:
		idle_move(delta)
	else:
		var mouse_x = get_global_mouse_position().x
		global_position.x = clamp(mouse_x, 72, 442.0)

func idle_move(delta):
	global_position.x += delta * direction
	if global_position.x < $Sprite2D.texture.get_width()*1.6 || global_position.x > 460:
		direction = -direction
	
func _on_area_entered(drop: Area2D) -> void:
	water_collected += 1
	drop.queue_free()
	if water_collected >= tank_capacity:
		water_collected = 0
		upgrade()
	$WaterTank/TextureBar.value = water_collected
	$WaterTank/Amount.text = str(water_collected)

func upgrade():
	$Sprite2D.scale.x +=0.2
	$CollisionShape2D.scale.x += 0.2
	$"../../World/Village/Rain".spawn_cloud(4+randf()*8,1)

func _on_check_button_toggled(toggled_on: bool) -> void:
	idle_on = toggled_on

func _on_button_pressed() -> void:
	upgrade()
