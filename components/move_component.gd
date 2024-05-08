class_name MoveComponent
extends Node

@export var actor: Node2D
@export var can_push: bool = false
@export var can_be_pushed: bool = false
@export var ray: RayCast2D
@export var cooldown: float = 0.1


var may_move = true


func move(velocity: Vector2) -> void:
	#if can_push:
		#aim_raycast(direction)
		#if ray.is_colliding():
			#var node = ray.get_collider()
			#push_actions.push(node, direction)
	if may_move:
		actor.position += velocity * Globals.GRID_SIZE
		may_move = false

