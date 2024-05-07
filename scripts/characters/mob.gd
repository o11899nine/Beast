extends CharacterBody2D

@onready var ray: RayCast2D = $RayCast2D
@onready var may_move: bool = true
@onready var move_cooldown: Timer = $MoveCooldownTimer

func _process(delta):
	# Remove mob if captured
	if is_captured():
		queue_free()
	# If move cooldown is over, move to a random adjacent unoccupied tile
	# and restart cooldown timer
	elif may_move:
		move(get_random_valid_direction())
		may_move = false
		move_cooldown.start()
		
func is_captured():
	# Loop over possible directions to move in. 
	# If any valid move found, return FALSE. If no valid moves, return TRUE
	for direction in Globals.MOVES_8D.keys():
		if is_valid_move(direction):
			return false
	return true
	
func get_random_valid_direction():
	# This function assumes there is at least one valid move, 
	# so don't call this if is_captured() returns TRUE
	
	# Shuffle all possible directions
	var directions = Globals.MOVES_8D.keys()
	directions.shuffle()
	print_debug(directions)
	# If the first direction is valid, return it. 
	# Else, remove it and check the new first direction
	for i in directions.size():
		if is_valid_move(directions[0]):
			return directions[0]
		directions.pop_front()
	
func _on_move_cooldown_timeout():
	may_move = true

func is_valid_move(direction: String):
	var vector_pos: Vector2 = Globals.MOVES_8D[direction] * Globals.GRID_SIZE
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()
	if ray.is_colliding():
		return false
	return true
			

func move(direction):
	position += Globals.MOVES_8D[direction] * Globals.GRID_SIZE
