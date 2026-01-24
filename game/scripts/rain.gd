extends Node2D

@export var cloud_scene: PackedScene
var cloud_rate = 4
var spawn_timer = 2.4

func _process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer > cloud_rate:
		spawn_timer = 0
		spawn_cloud()

func spawn_cloud():
	var green = 0
	for tree in $"../../Forest".get_children():
		if tree.age: green += tree.age
	var cloud := cloud_scene.instantiate()
	cloud.set_props(green/8.0)
	add_child(cloud)

func _physics_process(delta):
	for drop in get_tree().get_nodes_in_group("rain"):
		drop.global_position.y += 128 * delta
		if drop.global_position.y > 680:
			drop.queue_free()
