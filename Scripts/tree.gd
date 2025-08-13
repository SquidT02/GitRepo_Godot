extends Node2D

var health = 50
@onready var health_label = $Health
@onready var player = get_node("Player")
const BREAK_DISTANCE = 9999

func _ready():
	set_process_input(true)
	$Health.position = Vector2(-10 , -30)
	$Health.modulate = Color.RED

func _input(event):
	if event.is_action_pressed("break"):
		health -= 5
		$Health.text = str(health)
		if health <= 0:
			queue_free()
