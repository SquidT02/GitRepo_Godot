extends Node2D
@export var moveSpeed := 1
@onready var ground: TileMapLayer = $".."
var astar = AStarGrid2D.new()

var idPath := []
var used_idPath := []

### _Functions #################################################################
func _ready() -> void:
	setUpAstarGrid()

func _input(event: InputEvent) -> void:
	### if the player hasn't clicked, an input isnt ran to save processing power
	if event.is_action_pressed("Mouse Left") == false:
		return
		
	var Ipositipon := ground.local_to_map(global_position) ## the id location of the player on the tile map
	var mouseIposition := ground.local_to_map(get_global_mouse_position()) ## same for the mouse
	
	### idPath is an array of all id positions of the squares needed
	### to get from the player to the mouse (uses the variables above
	idPath = astar.get_id_path(Ipositipon, mouseIposition).slice(1) 
	### if there is an acual path it sets it to being used 
	### (prevents code trying to use functions on an empty arrray)
	if idPath.is_empty() == false:
		used_idPath = idPath
		
func _physics_process(delta):
		if used_idPath.is_empty():
			return
		### defines the position for the player to move towrds as the first element of the used path
		var targetPostion = ground.map_to_local(used_idPath.front())
		### moves the player towards target
		global_position = global_position.move_toward(targetPostion, moveSpeed)
		### repeats the code above as popping the front element creates a new target
		if global_position == targetPostion:
			used_idPath.pop_front()
			
		
### Functions ##################################################################
func setUpAstarGrid():
	astar.cell_shape = AStarGrid2D.CELL_SHAPE_ISOMETRIC_DOWN
	astar.cell_size = Vector2(32,16)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.region = ground.get_used_rect()
	astar.update()
