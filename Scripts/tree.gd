extends Node2D

var health = 30
@onready var health_label = $Health_tree


func _ready():
	set_process_input(true)
	$Health_tree.position = Vector2(-10 , -30)
	$Health_tree.modulate = Color.RED

func _input(event):
	if event.is_action_pressed("break"):
		health -= 5
		$Health_tree.text = str(health)
		if health <= 0:
			queue_free()
