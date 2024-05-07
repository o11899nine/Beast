extends CharacterBody2D

const MOVES: Dictionary = Globals.MOVES_8D

@export var can_push: bool = false
@export var can_be_pushed: bool = false

@onready var ray: RayCast2D = $RayCast2D
@onready var move_cooldown: Timer = $MoveCooldownTimer

var may_move: bool = true

func _ready():
	if can_be_pushed:
		add_to_group("can_be_pushed")
		
func _process(delta):
	# Remove mob if captured
	if is_captured():
		queue_free()
	# If move cooldown is over, move to a random adjacent unoccupied tile
	# and restart cooldown timer
	elif may_move:
		move_and_push(get_random_valid_direction())
		may_move = false
		move_cooldown.start()


func is_captured():
	# Loop over possible directions to move in. 
	# If any valid move found, return FALSE. If no valid moves, return TRUE
	for direction in MOVES.keys():
		if is_valid_move(direction):
			return false
	return true


func get_random_valid_direction():
	# This function assumes there is at least one valid move, 
	# so don't call this if is_captured() returns TRUE
	
	# Shuffle all possible directions
	var directions: Array = MOVES.keys()
	directions.shuffle()

	# If the first direction is valid, return it. 
	# Else, remove it and check the new first direction
	for i in directions.size():
		if is_valid_move(directions[0]):
			return directions[0]
		directions.pop_front()

func aim_ray(direction):
	# Get vector by multiplying the directions's vector by the grid size
	var vector_pos: Vector2 = MOVES[direction] * Globals.GRID_SIZE
	# Aim Raycast at target position
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()

func is_valid_move(direction: String):
	# If this entity can't move in the given direction, return false
	if not direction in MOVES.keys():
		return false
		
	aim_ray(direction)
	# If the target position is unoccupied, return TRUE
	if not ray.is_colliding():
		return true
	# If the target position is occupied and this entity can push,
	# Check if the object in the target position can be pushed
	elif can_push:
			var object: Object = ray.get_collider()
			if object.is_in_group("can_be_pushed"):
				# If pushing the object is a valid move, move the object
				# and return TRUE
				if object.is_valid_move(direction):
					return true
	# If the target position is occupied and this entity cannot push, return FALSE
	return false



func move_and_push(direction):
	aim_ray(direction)
	var object: Object = ray.get_collider()
	object.move_and_push(direction)
	position += MOVES[direction] * Globals.GRID_SIZE


func _on_move_cooldown_timeout():
	may_move = true
