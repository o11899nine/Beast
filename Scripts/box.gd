extends CharacterBody2D

const GRID_SIZE = 16

@onready var ray = $RayCast2D

const MOVEMENT = {
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
}

func can_move(direction):
	var vector_pos = MOVEMENT[direction] * GRID_SIZE
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()
	if not ray.is_colliding():
		return true

func move(direction):
	position += MOVEMENT[direction] * GRID_SIZE
		
