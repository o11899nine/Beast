extends Node2D

var grid_size: int = Globals.GRID_SIZE
var empty_squares: Array

func _ready():
	
	randomize()

	var viewport_width = get_viewport_rect().size.x
	var viewport_height = get_viewport_rect().size.y
	
	empty_squares = get_available_squares(viewport_width, viewport_height)
	
	var num_blocks = empty_squares.size() / 2.0
	
	spawn_blocks(num_blocks)
	spawn_player()
	spawn_mobs(0)
	
	
	
	
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
	
	possible_x.pop_front()
	possible_x.pop_back()
	possible_y.pop_front()
	possible_y.pop_back()
	var coordinates = []
		
	for y in possible_y:
		for x in possible_x:
			coordinates.append(Vector2(x, y))
			
	return coordinates	
	
	
func spawn_blocks(n):
	empty_squares.shuffle()
	for i in n:
		var block = preload("res://scenes/objects/block.tscn").instantiate()
		var block_position = empty_squares[-1]
		empty_squares.pop_back()
				
		block.global_position = block_position
		add_child(block)
	
func spawn_player():
	empty_squares.shuffle()

	var player = preload("res://scenes/characters/player.tscn").instantiate()
	var player_position = empty_squares[-1]
	empty_squares.pop_back()		
	player.global_position = player_position
	add_child(player)
	
func spawn_mobs(n):
	
	empty_squares.shuffle()
	for i in n:
		var mob = preload("res://scenes/characters/mob.tscn").instantiate()
		var mob_position = empty_squares[-1]
		empty_squares.pop_back()		
		mob.global_position = mob_position
		add_child(mob)
	
