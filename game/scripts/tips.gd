extends Label

var tips := [
	"Rain is not the same as water. Rain is not the same as water. Rain is not the same as water.",
	"You can only fight what you can reach.",
	"Progress is cumulative, not linear.",
    "Some systems hide their intent."
]

var index := 0

func _ready():
	_tip_loop()

func _tip_loop():
	while true:
		text = "TIP: " + tips[index]
		index = (index + 1) % tips.size()
		await get_tree().create_timer(1.0).timeout
