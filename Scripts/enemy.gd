extends CharacterBody2D

const GRID_SIZE = 16

@onready var ray = $RayCast2D

const MOVEMENT = {
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
}


func _on_move_cooldown_timeout():
	var direction = false
	while not can_move(direction):	
		direction = MOVEMENT.keys().pick_random()
	move(direction)
	
func can_move(direction):
	if not direction:
		return false
	var vector_pos = MOVEMENT[direction] * GRID_SIZE
	ray.set_target_position(vector_pos)
	ray.force_raycast_update()
	if not ray.is_colliding():
		return true
			

func move(direction):
	
	var target_position = MOVEMENT[direction] * GRID_SIZE
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


