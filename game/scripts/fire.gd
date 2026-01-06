extends Node2D

@export var fire_tex: Texture2D
@export var spawn_interval := 1.6

var spawn_timer := 0.0
var fires = []

func _ready():
	spawn_timer = spawn_interval

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_timer = spawn_interval
		spawn_fire_at($"..".trees[randf()*$"..".trees.size()])
		

func spawn_fire_at(tree):
	var sprite := Sprite2D.new()
	sprite.texture = fire_tex
	var fire := Area2D.new()
	fire.position = tree.position
	fire.add_child(sprite)
	var collision := CollisionShape2D.new()
	var shape := CircleShape2D.new()
	shape.radius = 6
	collision.shape = shape
	fire.set_collision_mask_value(3,true)
	fire.set_collision_layer_value(3,true)
	fire.add_child(collision)
	fires.append(fire)
	add_child(fire)


func _on_truck_spray_on() -> void:
	print("poof")
