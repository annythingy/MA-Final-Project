extends Node2D

@export var tree_tex: Texture2D
var trees = []

func _ready() -> void:
	spawn_tree_at(Vector2(768,256))
	for i in 4:
		spawn_tree_at(Vector2(544 + randf() * 448 , 32 + randf() * 448))

func spawn_tree_at(pos: Vector2):
	var tree := StaticBody2D.new()
	tree.position = pos

	var sprite := Sprite2D.new()
	sprite.texture = tree_tex
	sprite.scale = Vector2(0.8, 0.8)
	tree.add_child(sprite)

	var collision := CollisionShape2D.new()
	var shape := CircleShape2D.new()
	shape.radius = 24  # Increase radius to match tree sprite size
	collision.shape = shape
	tree.add_child(collision)
	trees.append(tree)
	add_child(tree)
