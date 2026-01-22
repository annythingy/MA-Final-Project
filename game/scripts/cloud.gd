extends Node2D

@export var raindrop_tex: Texture2D
@export var drop_rate := 1.2
@export var fall_speed := 128
@export var float_speed = 16

var water_timer := 0.0
var ratio = 3.2
var width = 0.0
var wind = 0

func _ready():
	water_timer = drop_rate

func _physics_process(delta: float) -> void:
	water_timer -= delta
	move_about(delta)
	make_rain()

func set_props(x):
	width = x
	wind = randi() % 2 * 2 - 1
	float_speed = 128.0 / x
	drop_rate = x / 12.8
	var altitude = x * ratio * 9.2
	$Sprite2D.scale = Vector2(x,x/ratio)
	position = Vector2(randf()*428,686-altitude)
	
func move_about(delta):
	position.x += delta * wind * float_speed
	var sprite_pos_x = $Sprite2D.global_position.x
	if sprite_pos_x < 32|| sprite_pos_x > 512:
		queue_free()
	#if sprite_pos_x > 256-width*scale.x: $Sprite2D.self_modulate = Color(1,1,1,255/sprite_pos_x)

func make_rain():
	if water_timer <= 0:
		water_timer = drop_rate
		spawn_drop()

func spawn_drop():
	var drop := Area2D.new()
	var sprite := Sprite2D.new()
	var shape := CircleShape2D.new()
	var collision := CollisionShape2D.new()
	sprite.texture = raindrop_tex
	shape.radius = 6
	collision.shape = shape
	drop.add_child(sprite)
	drop.add_child(collision)
	var area_x = $Sprite2D.scale.x * width
	var local_x = randf_range(-area_x / 2.0, area_x / 2.0)
	var local_y = 12 + $Sprite2D.scale.y * 8
	var spawn_pos = global_position + Vector2(local_x, local_y)
	spawn_pos.x = min(max(64,spawn_pos.x), 464)
	drop.global_position = spawn_pos
	drop.add_to_group("rain")
	get_tree().current_scene.add_child(drop)
