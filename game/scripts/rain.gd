extends Node2D

@export var cloud_scene: PackedScene
@export var spawn_rate_cloud := 4
var cloud_timer = 0.0
var raindrops = []

func _ready() -> void:
	spawn_cloud(12,1)

func spawn_cloud(size,wind):
	var cloud := cloud_scene.instantiate()
	cloud.set_props(size,wind)
	add_child(cloud)
