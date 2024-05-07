extends CharacterBody2D

@onready var ray: RayCast2D = $RayCast2D
@onready var may_move: bool = true
@onready var move_cooldown: Timer = $MoveCooldownTimer

func _process(delta):
	# If move cooldown is over, listen for direction input.
	if may_move:
		for direction in Globals.MOVES_4D:
			if Input.is_action_pressed(direction):
				# If the adjacent tile in the direction is unoccupied, 
				# move there and restart move cooldown timer
				if is_valid_move(direction):
					move(direction)
					may_move = false
					move_cooldown.start()
				

func is_valid_move(direction: String):
	var vector_pos: Vector2 = Globals.MOVES_4D[direction] * Globals.GRID_SIZE
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()
	
	if not ray.is_colliding():
		return true
	else:
		var collider: Object = ray.get_collider()
		if collider.is_in_group("moveable_objects"):
			if collider.is_valid_move(direction):
				collider.move(direction)
				return true
			else:
				return false

func move(direction):
	position += Globals.MOVES_4D[direction] * Globals.GRID_SIZE


func _on_move_cooldown_timeout():
	may_move = true
