extends Node

var tips := [
	"Rain is not the same as water. Rain is not the same as water. Rain is not the same as water.",
	"You can only fight what you can reach.",
	"Progress is cumulative, not linear.",
    "Some systems hide their intent."
]

@export var tex_mouse0: Texture2D
@export var tex_mouse1: Texture2D
@export var tex_mouse2: Texture2D

var index := 0
var timer = 0.0
var progress_rate = 1

func _ready():
	$ProgressBar/StartButton.visible = false
	_loop_tips()
	$ProgressBar/StartButton.pressed.connect(_end_start)

func _process(delta: float) -> void:
	timer += delta
	if timer >= progress_rate:
		timer = 0
		$ProgressBar.value += 25
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$Steering/Mouse.texture = tex_mouse1
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		$Steering/Mouse.texture = tex_mouse2
	else:
		$Steering/Mouse.texture = tex_mouse0
	
	if $ProgressBar.value >= $ProgressBar.max_value:
		$ProgressBar/StartButton.visible = true
		
func _loop_tips():
	while true:
		$Tips/TipTxt.text = "TIP: " + tips[index]
		index = (index + 1) % tips.size()
		await get_tree().create_timer(1.0).timeout

func _end_start():
	$"../World/Forest".ignite()#get_tree().quit()
