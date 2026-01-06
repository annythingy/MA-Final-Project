extends Node2D

@export var raindrop_tex: Texture2D
@export var spawn_rate_water := 1.2
@export var fall_speed := 128
@export var float_speed = 16

var water_timer := 0.0
var raindrops = []
var width = 0.0
var wind = 0

func _ready():
	water_timer = spawn_rate_water

func _process(delta):
	water_timer -= delta
	move_about(delta)
	make_rain()
	make_rain_fall(delta)

func set_props(x,direction):
	width = x
	wind = direction
	spawn_rate_water = x/12.0
	var ratio = 3.2
	var altitude = x*10*ratio
	$Sprite2D.scale = Vector2(x,x/ratio)
	position = Vector2(randf()*428,686-altitude)
	
func move_about(delta):
	var direction = delta * 1
	position.x += float_speed * direction
	if $Sprite2D.global_position.x < 0|| $Sprite2D.global_position.x > 480:
		queue_free()

func make_rain():
	if water_timer <= 0:
		water_timer = spawn_rate_water
		spawn_drop()

func spawn_drop():
	var drop := Area2D.new()
	var sprite := Sprite2D.new()
	var shape := CircleShape2D.new()
	var collision := CollisionShape2D.new()
	sprite.texture = raindrop_tex
	shape.radius = 6
	collision.shape = shape
	
	var areaX = $Sprite2D.scale.x*8
	#TODO do not spawn out of bounds rain
	drop.position = Vector2(-areaX/2+randf()*areaX, 12+$Sprite2D.scale.y*8)
	
	drop.add_child(sprite)
	drop.add_child(collision)
	raindrops.append(drop)
	add_child(drop)

func make_rain_fall(delta):
	for drop in raindrops:
		if is_instance_valid(drop):
			drop.position.y += fall_speed * delta
			if drop.position.y > 442:
				raindrops.remove_at(raindrops.find(drop))
				drop.queue_free()
