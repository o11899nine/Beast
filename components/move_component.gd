class_name MoveComponent
extends Node

@export var actor: Node2D
@export var ray: RayCast2D
@export_range(1, INF, 1, "or_greater", "or_greater") var speed: int = 10
@export var can_push: bool = false
@export var can_be_pushed: bool = false

var timer: Timer = Timer.new()
var may_move: bool = false

func _ready():
	timer.wait_time = 10 / speed * 0.1
	timer.timeout.connect(_on_timer_timeout)
	actor.add_child.call_deferred(timer)
	timer.autostart = true
	may_move = true
	

func _on_timer_timeout() -> void:
	may_move = true


func move(velocity: Vector2) -> void:
	#if can_push:
		#aim_raycast(direction)
		#if ray.is_colliding():
			#var node = ray.get_collider()
			#push_actions.push(node, direction)
	if may_move:
		actor.position += velocity * Globals.GRID_SIZE

