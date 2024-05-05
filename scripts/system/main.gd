extends Node2D

var grid_size = Globals.GRID_SIZE

var available_squares

func _ready():

	var viewport_width = get_viewport_rect().size.x
	var viewport_height = get_viewport_rect().size.y
	
	available_squares = get_available_squares(viewport_width, viewport_height)
	
	print(available_squares.size())
	spawn_blocks(available_squares.size() / 2)
	print(available_squares.size())
	
	
	
func get_available_squares(viewport_width, viewport_height):
	var x_coord = 0
	var y_coord = 0
	
	var possible_x = []
	var possible_y = []
	
	while x_coord < viewport_width:
		possible_x.append(x_coord)
		x_coord += grid_size
	while y_coord < viewport_height:
		possible_y.append(y_coord)
		y_coord += grid_size
		
	var coordinates = []
		
	for y in possible_y:
		for x in possible_x:
			coordinates.append(Vector2(x, y))
			
	return coordinates	
	
	
func spawn_blocks(n):
	randomize()
	available_squares.shuffle()
	for i in n:
		var block = preload("res://scenes/objects/block.tscn").instantiate()
		var block_position = available_squares[-1]
		available_squares.pop_back()
				
		block.global_position = block_position
		add_child(block)
	
