extends CharacterBody2D

var grid_size = Globals.GRID_SIZE

@onready var ray = $RayCast2D

const MOVEMENT = {
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
}


func _process(delta):
	var can_move = false
	var possible_moves = MOVEMENT.keys()
	var direction = null
	
	for i in possible_moves.size():
		possible_moves.shuffle()
		direction = possible_moves[0]
		possible_moves.pop_front()
		if is_valid_move(direction):
			can_move = true
			break
	
	if not can_move:
		queue_free()
		
func _on_move_cooldown_timeout():
	var can_move = false
	var possible_moves = MOVEMENT.keys()
	var direction = null
	
	for i in possible_moves.size():
		possible_moves.shuffle()
		direction = possible_moves[0]
		possible_moves.pop_front()
		if is_valid_move(direction):
			can_move = true
			break
	
	if can_move:
		move(direction)

func is_valid_move(direction):
	var vector_pos = MOVEMENT[direction] * grid_size
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()
	if not ray.is_colliding():
		return true
	else:
		return false
			

func move(direction):
	
	var target_position = MOVEMENT[direction] * grid_size
	ray.set_target_position(target_position)
	ray.force_raycast_update()
	
	if not ray.is_colliding():
		position += target_position
	else:
		var collider = ray.get_collider()
		if collider.has_method("can_move"):
			if collider.can_move(direction):
				collider.move(direction)
				position += target_position

