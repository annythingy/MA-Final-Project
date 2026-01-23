extends Node2D

@export var tree_tex1: Texture2D
@export var tree_tex2: Texture2D
@export var tree_tex3: Texture2D
@export var tree_tex4: Texture2D
@export var tree_tex0: Texture2D
@export var flame_tex: Texture2D

var forest: Node2D
var idx: int
var texture: Texture2D
var age = 1
var is_burning = false
var timer = 0.0
var decay_left = 6
var burn_left = 5
var age_rate = 2
	
func _process(delta: float) -> void:
	timer += delta
	if timer >= age_rate:
		timer = 0
		if age > 0 && !is_burning: grow()
		if is_burning: burn()
		if age == 0: decay()

func grow():
	if    age == 4: propagate()
	else: age += 1
	match age:
		1: $Sprite2D.texture = tree_tex1
		2: $Sprite2D.texture = tree_tex2
		3: $Sprite2D.texture = tree_tex3
		4: $Sprite2D.texture = tree_tex4

func set_on_fire():
	if is_burning == true: return
	var flame := Area2D.new()
	flame.position = global_position  # Use global position if top_level true
	var sprite := Sprite2D.new()
	sprite.texture = flame_tex
	flame.add_child(sprite)
	var collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 12
	collision_shape.shape = circle_shape
	flame.add_child(collision_shape)
	flame.top_level = true
	flame.collision_layer = 3
	flame.monitoring = true
	add_child(flame)
	flame.add_to_group('fire')
	is_burning = true

func put_off_fire():
	is_burning = false
	for f in get_children():
		if f.is_in_group('fire'):
			get_parent().log_fire_out()
			remove_child(f)

func burn():
	burn_left-=1
	if burn_left <=0: wither()
	var num_close = get_neighbours().size()
	if num_close > 0:
		var next_burn = get_neighbours()[randi() % num_close]
		next_burn.set_on_fire()

func wither():
	#for f in get_children():
		#if f.is_in_group('fire'):
			#remove_child(f)
	$CollisionShape2D.disabled = true
	$Sprite2D.texture = tree_tex0
	age = 0
	
func decay():
	decay_left -= 1
	if decay_left <= 0:
		forest.trees[idx] = null
		queue_free()

func get_endurance() -> int:
	if age > 0: return age * 2
	else: return 3

func get_neighbours():
	var group = []
	for t in forest.trees:
		if t != null && abs(t.position.x - position.x) < 64 && abs(t.position.y - position.y) < 64:
			group.append(t)
	return group
	
func is_free(x,y) -> bool:
	if !is_inside(x,y): return false
	for t in forest.trees:
		if t != null && abs(t.position.x - x) < 32 && abs(t.position.y - y) < 32:
			return false
	return true

func is_inside(x,y) -> bool:
	return x > 576 && x < 960 && y > 64 && y < 448
	
func propagate():
	var baby_x = position.x + randi_range(-64, 64)
	var baby_y = position.y + randi_range(-64, 64)
	if is_free(baby_x, baby_y):
		forest.spawn_tree_at(Vector2(baby_x,baby_y))
