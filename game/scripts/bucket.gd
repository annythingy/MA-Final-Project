extends Area2D

@export var tank_capacity = 8
var water_collected = 0
var water_in_tank = 0
var direction: int = -1
var upgr_incr = 0.16
@export var upgr_req = 32
var auto_on = false
@export var speed = Vector2(32, 0)

func b_width(): return  32 * $Sprite2D.scale.x
func x_left(): 	return  64 + b_width() / 2
func x_right(): return 480 - b_width() / 2

var drop_targ = null

func _ready() -> void:
	$WaterTank/TextureBar.max_value = tank_capacity

func _physics_process(delta):
	if auto_on: move_ai(delta)
	else:		move_lr(delta)
	if at_wall(): bounce_flush()
	
	$"../../UI/Steering/Upgrade".disabled = !can_upgrade()
	$WaterTank/TextureBar.value = water_in_tank
	$WaterTank/Amount.text  = str(water_in_tank,"\n/",tank_capacity)

func move_ai(delta): 
	if water_in_tank / tank_capacity > 0.8:
		var dist_left  = abs(global_position.x -  64)
		var dist_right = abs(global_position.x - 480)
		direction = sign(dist_left - dist_right)
	else:
		if drop_targ == null: drop_targ = get_tree().get_first_node_in_group("rain")
		else: direction = sign(drop_targ.global_position.x - global_position.x)
	global_position.x += delta * speed.x/2 * direction
		
func move_lr(delta):
	global_position.x = clamp(global_position.x, x_left(), x_right())	
	if Input.is_action_pressed("wRight"):  position += speed * delta
	elif Input.is_action_pressed("wLeft"): position -= speed * delta

func bounce_flush():
	water_collected += water_in_tank
	water_in_tank = 0
	direction = -direction

func pump_water():
	$"../Truck".water_supply += 2

func at_wall() -> bool: 	return global_position.x < x_left() || global_position.x > x_right()

func can_upgrade() -> bool:	
	return water_collected >= upgr_req

func _on_area_entered(drop: Area2D) -> void:
	drop.queue_free()
	if water_in_tank < tank_capacity:
		water_in_tank += 1

func get_upgr_lvl() -> int:
	return round(($Sprite2D.scale.x-1)/0.16)

func upgrade():
	pump_water()
	tank_capacity += get_upgr_lvl()
	$Sprite2D.scale.x += upgr_incr
	$CollisionShape2D.scale.x += upgr_incr
	$WaterTank/Amount.position.x += upgr_incr * 15
	$WaterTank/TextureBar.position.x -= upgr_incr * 15
	$WaterTank/TextureBar.max_value = tank_capacity
	$"../../UI/Steering/Upgrade/Level".text = str(get_upgr_lvl())

func _on_check_button_toggled(toggled_on: bool) -> void:
	auto_on = toggled_on

func _on_upgrade_pressed() -> void:
	upgrade()
