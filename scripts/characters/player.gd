extends CharacterBody2D

var grid_size = Globals.GRID_SIZE


const MOVEMENT = {
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN,
	"move_left": Vector2.LEFT,
	"move_right": Vector2.RIGHT,
}

@onready var ray = $RayCast2D
@onready var may_move = true

func _physics_process(delta):
	if may_move:
		for direction in MOVEMENT:
			if Input.is_action_pressed(direction):
				move(direction)
				may_move = false
				$MoveCooldown.start()
				
				

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


func _on_move_cooldown_timeout():
	may_move = true
