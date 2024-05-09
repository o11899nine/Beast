class_name MoveComponent
extends Node

@export var actor: Node2D
@export var ray: RayCast2D


func move_and_push(velocity: Vector2) -> void:
	if ray.is_colliding():
		var obstacle = ray.get_collider()
		push(obstacle, velocity)
	actor.position += velocity * Globals.GRID_SIZE

	
func is_valid_move(velocity: Vector2) -> bool:
	aim_raycast(velocity)
	if not ray.is_colliding():
		return true
	else:
		var obstacle = ray.get_collider()
		if can_be_crushed(obstacle) and can_crush():
			return true
		elif can_be_pushed(obstacle) and can_push():
			if obstacle.get_node("MoveComponent").is_valid_move(velocity):
				return true
	return false
	

func can_push():
	if actor.has_node("PushComponent"):
		return true
	return false
	
func can_be_pushed(obstacle: Node2D):
	if obstacle.has_node("PushableComponent"):
		return true
	return false

func can_crush():
	if actor.has_node("CrushComponent"):
		return true
	return false
	
func can_be_crushed(obstacle: Node2D):
	if obstacle.has_node("CrushableComponent"):
		return true
	return false
		

func push(obstacle: Node2D, velocity: Vector2) -> void:
	obstacle.get_node("MoveComponent").move_and_push(velocity)
	
func crush(obstacle: Node2D):
	obstacle.queue_free()

func aim_raycast(velocity: Vector2) -> void:
	ray.set_target_position(velocity * Globals.GRID_SIZE)
	ray.force_raycast_update()
