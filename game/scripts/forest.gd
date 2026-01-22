extends Node2D

@export var tree_scene: PackedScene
var trees = []

func _ready() -> void:
	#spawn_tree_at(Vector2(888,222))
	for i in 12:		spawn_tree_at(Vector2(544 + randf() * 448 , 32 + randf() * 448))
	ignite()

func spawn_tree_at(pos: Vector2):
	var tree := tree_scene.instantiate()
	tree.position = pos
	tree.idx = trees.size()
	trees.append(tree)
	tree.forest = $"."
	add_child(tree)	

func ignite():
	var jinx: StaticBody2D = null
	while jinx == null:
		jinx = trees[randf()*trees.size()]
	jinx.set_on_fire()
