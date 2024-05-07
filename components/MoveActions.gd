extends Node2D

@onready var parent = get_parent()
@onready var moves = parent.MOVES
@onready var ray = $RayCast2D

var push_actions: Node2D
var can_push: bool = false

func _ready():
	if parent.has_node("PushActions"):
		push_actions = parent.get_node("PushActions")
		can_push = true

func move(direction: String) -> void:
	if can_push:
		aim_raycast(direction)
		if ray.is_colliding():
			var node = ray.get_collider()
			push_actions.push(node, direction)
	parent.position += moves[direction] * Globals.GRID_SIZE
	
func aim_raycast(direction: String) -> void:
	var target_position: Vector2 = moves[direction] * Globals.GRID_SIZE
	ray.set_target_position(target_position)
	ray.force_raycast_update()
	
func is_valid_move(direction: String) -> bool:
	aim_raycast(direction)
	if not ray.is_colliding():
		return true
	elif can_push:
		var collider: Node = ray.get_collider()
		if collider.has_node("PushActions") and collider.has_node("MoveActions"):
				if collider.get_node("MoveActions").is_valid_move(direction):
					return true
	return false
