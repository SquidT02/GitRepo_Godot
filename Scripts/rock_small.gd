extends Node2D

var health = 45
@onready var health_label = $Health_rock_small


func _ready():
	set_process_input(true)
	$Health_rock_small.position = Vector2(-10 , -30)
	$Health_rock_small.modulate = Color.RED

func _input(event):
	if event.is_action_pressed("break"):
		health -= 5
		$Health_rock_small.text = str(health)
		if health <= 0:
			queue_free()
