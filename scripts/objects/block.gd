extends CharacterBody2D

@onready var ray = $RayCast2D

func is_valid_move(direction):
	var vector_pos = Globals.MOVES_4D[direction] * Globals.GRID_SIZE
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()
	
	if not ray.is_colliding():
		return true
	else:
		var collider = ray.get_collider()
		if collider.is_in_group("moveable_objects"):
			if collider.is_valid_move(direction):
				collider.move(direction)
				return true
			else:
				return false

func move(direction):
	position += Globals.MOVES_4D[direction] * Globals.GRID_SIZE
		
