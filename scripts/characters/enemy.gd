extends CharacterBody2D

var grid_size = Globals.GRID_SIZE

@onready var ray = $RayCast2D

signal die

const MOVEMENT = {
	"move_north": Vector2(0,-1),
	"move_south": Vector2(0,1),
	"move_west": Vector2(-1,0),
	"move_east": Vector2(1,0),
	"move_north_east": Vector2(1,-1),
	"move_south_east": Vector2(1,1),
	"move_north_west": Vector2(-1,-1),
	"move_south_west": Vector2(-1,1),
}


func _process(delta):
	
	var valid_move = find_valid_move()
	
	if not valid_move:
		queue_free()
		

func find_valid_move():
	
	var can_move = false
	var possible_moves = MOVEMENT.keys()
	var direction = null
	
	for i in possible_moves.size():
		possible_moves.shuffle()
		direction = possible_moves[0]
		possible_moves.pop_front()
		if is_valid_move(direction):
			return direction
	return false
	
func _on_move_cooldown_timeout():
	
	var direction = find_valid_move()
	
	if direction:
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
	position += MOVEMENT[direction] * grid_size



func _on_die():
	queue_free()
