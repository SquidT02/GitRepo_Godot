extends Node2D

var health = 30
@onready var health_label = $Health_tree


func _ready():
	set_process_input(true)
	health_label.position = Vector2(-10 , -30)
	health_label.modulate = Color.RED

func _input(event):
	if event.is_action_pressed("break"):
		health -= 5
		health_label.text = str(health)
		if health <= 0:
			queue_free()
