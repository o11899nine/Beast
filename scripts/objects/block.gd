extends CharacterBody2D

var grid_size = Globals.GRID_SIZE

@onready var ray = $RayCast2D

const MOVEMENT = {
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
}


func can_move(direction):
	var vector_pos = MOVEMENT[direction] * grid_size
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()
	if not ray.is_colliding():
		return true
	else:
		var collider = ray.get_collider()
		if collider.has_method("can_move"):
			if collider.can_move(direction):
				collider.move(direction)
				return true

func move(direction):
	position += MOVEMENT[direction] * grid_size
		
