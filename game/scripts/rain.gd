extends Node2D

@export var cloud_scene: PackedScene
var cloud_timer = 0.0

func _ready() -> void:
	spawn_cloud(12)

func spawn_cloud(size):
	var cloud := cloud_scene.instantiate()
	cloud.set_props(size)
	add_child(cloud)

func _physics_process(delta):
	for drop in get_tree().get_nodes_in_group("rain"):
		drop.global_position.y += 128 * delta
		# optional: apply wind or other global forces
		if drop.global_position.y > 640:
			drop.queue_free()
