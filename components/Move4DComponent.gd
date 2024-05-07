extends Node2D

@onready var parent = get_parent()
@onready var ray = $RayCast2D

const MOVES = {
	"move_north": Vector2(0,-1),
	"move_south": Vector2(0,1),
	"move_west": Vector2(-1,0),
	"move_east": Vector2(1,0),
}

func move(direction: String) -> void:
	if parent.has_node("PusherComponent"):
		aim_raycast(direction)
		if ray.is_colliding():
			parent.get_node("PusherComponent").push(ray.get_collider(), direction)
	parent.position += MOVES[direction] * Globals.GRID_SIZE
	
func aim_raycast(direction: String) -> void:
	var target_position: Vector2 = MOVES[direction] * Globals.GRID_SIZE
	ray.set_target_position(target_position)
	ray.force_raycast_update()
	
func is_valid_move(direction: String) -> bool:
	aim_raycast(direction)
	if not ray.is_colliding():
		return true
	elif parent.has_node("PusherComponent"):
		var collider: Node = ray.get_collider()
		if collider.has_node("PushableComponent") and collider.has_node("Move4DComponent"):
				if collider.get_node("Move4DComponent").is_valid_move(direction):
					return true
	return false
