extends StaticBody2D

const MOVES: Dictionary = Globals.MOVES_4D

@export var can_push: bool = true
@export var can_be_pushed: bool = true

@onready var ray: RayCast2D = $RayCast2D


func _init() -> void:
	if can_push: add_to_group("pushers")
	if can_be_pushed: add_to_group("pushables")


func aim_raycast(direction: String) -> void:
	var target_position: Vector2 = MOVES[direction] * Globals.GRID_SIZE
	ray.set_target_position(target_position)
	ray.force_raycast_update()

func is_valid_move(direction: String) -> bool:
	aim_raycast(direction)
	if not ray.is_colliding():
		return true
	elif can_push:
		var collider: Object = ray.get_collider()
		if collider.is_in_group("pushables"):
			if collider.is_valid_move(direction):
				return true
	return false

func move_and_push(direction: String) -> void:
	if ray.is_colliding():
		push(ray.get_collider(), direction)		
	move(direction)


func push(object: Object, direction: String) -> void:
	object.move_and_push(direction)


func move(direction: String) -> void:
	position += MOVES[direction] * Globals.GRID_SIZE
